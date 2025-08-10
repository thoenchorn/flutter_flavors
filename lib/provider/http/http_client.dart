import 'dart:convert';
import 'package:http/http.dart' as http;

/// Progress callback for file downloads
typedef ProgressCallback = void Function(int received, int total);

/// Abstract class for HTTP client operations
/// Provides all HTTP methods using the http package
abstract class HttpClient {
  /// Base URL for the API
  String get baseUrl;

  /// Default headers to be sent with every request
  Map<String, String> get defaultHeaders;

  /// Timeout duration for requests (default: 30 seconds)
  Duration get timeout => const Duration(seconds: 30);

  /// GET request
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// POST request
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Object? body,
  });

  /// PUT request
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  });

  /// PATCH request
  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Object? body,
  });

  /// DELETE request
  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Download file
  Future<void> downloadFile(
    String path, {
    required String savePath,
    required ProgressCallback onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}

/// Exception class for HTTP errors
class HttpException implements Exception {
  final String message;
  final int statusCode;
  final String? responseBody;

  HttpException(this.message, this.statusCode, [this.responseBody]);

  @override
  String toString() => 'HttpException: $message';
}

/// Concrete implementation of HttpClient
class HttpClientImpl extends HttpClient {
  final http.Client _client;

  HttpClientImpl({http.Client? client}) : _client = client ?? http.Client();

  @override
  String get baseUrl => throw UnimplementedError('baseUrl must be implemented');

  @override
  Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final mergedHeaders = _mergeHeaders(headers);

    final response = await _client
        .get(url, headers: mergedHeaders)
        .timeout(timeout);

    _handleError(response);
    return _parseResponse(response);
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Object? body,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final mergedHeaders = _mergeHeaders(headers);

    final response = await _client
        .post(url, headers: mergedHeaders, body: body)
        .timeout(timeout);

    _handleError(response);
    return _parseResponse(response);
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final mergedHeaders = _mergeHeaders(headers);

    final response = await _client
        .put(url, headers: mergedHeaders, body: body != null ? jsonEncode(body) : null)
        .timeout(timeout);

    _handleError(response);
    return _parseResponse(response);
  }

  @override
  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Object? body,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final mergedHeaders = _mergeHeaders(headers);

    final response = await _client
        .patch(url, headers: mergedHeaders, body: body)
        .timeout(timeout);

    _handleError(response);
    return _parseResponse(response);
  }

  @override
  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final mergedHeaders = _mergeHeaders(headers);

    final response = await _client
        .delete(url, headers: mergedHeaders)
        .timeout(timeout);

    _handleError(response);
    return _parseResponse(response);
  }

  @override
  Future<void> downloadFile(
    String path, {
    required String savePath,
    required ProgressCallback onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final url = _buildUrl(path, queryParameters);
    final mergedHeaders = _mergeHeaders(headers);

    final request = http.Request('GET', url);
    request.headers.addAll(mergedHeaders);

    final streamedResponse = await _client.send(request).timeout(timeout);
    
    if (streamedResponse.statusCode >= 400) {
      throw HttpException(
        'HTTP ${streamedResponse.statusCode}: ${streamedResponse.reasonPhrase}',
        streamedResponse.statusCode,
      );
    }

    final totalBytes = streamedResponse.contentLength ?? 0;
    int receivedBytes = 0;

    final file = await _createFile(savePath);
    final sink = file.openWrite();

    await for (final chunk in streamedResponse.stream) {
      sink.add(chunk);
      receivedBytes += chunk.length;
      onReceiveProgress(receivedBytes, totalBytes);
    }

    await sink.close();
  }

  /// Build the full URL with query parameters
  Uri _buildUrl(String path, Map<String, dynamic>? queryParameters) {
    final uri = Uri.parse('$baseUrl$path');
    
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryParams = <String, String>{};
      queryParameters.forEach((key, value) {
        if (value != null) {
          queryParams[key] = value.toString();
        }
      });
      return uri.replace(queryParameters: queryParams);
    }
    
    return uri;
  }

  /// Merge default headers with request-specific headers
  Map<String, String> _mergeHeaders(Map<String, dynamic>? requestHeaders) {
    final mergedHeaders = Map<String, String>.from(defaultHeaders);
    if (requestHeaders != null) {
      requestHeaders.forEach((key, value) {
        if (value != null) {
          mergedHeaders[key] = value.toString();
        }
      });
    }
    return mergedHeaders;
  }

  /// Handle common HTTP errors
  void _handleError(http.Response response) {
    if (response.statusCode >= 400) {
      throw HttpException(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        response.statusCode,
        response.body,
      );
    }
  }

  /// Parse HTTP response to Map<String, dynamic>
  Map<String, dynamic> _parseResponse(http.Response response) {
    if (response.body.isEmpty) {
      return {};
    }
    
    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw HttpException(
        'Failed to parse response: $e',
        response.statusCode,
        response.body,
      );
    }
  }

  /// Create file for download
  Future<dynamic> _createFile(String savePath) async {
    // This would need to be implemented based on your file system access
    // For now, we'll throw an exception
    throw UnimplementedError('File creation not implemented. Use dart:io File for actual implementation.');
  }

  /// Close the HTTP client
  void close() {
    _client.close();
  }
}
