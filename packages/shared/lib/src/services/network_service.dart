/// Network service interface for HTTP operations
abstract class NetworkService {
  /// Perform GET request
  Future<NetworkResponse> get(String url, {Map<String, String>? headers});

  /// Perform POST request
  Future<NetworkResponse> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  /// Perform PUT request
  Future<NetworkResponse> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  /// Perform PATCH request
  Future<NetworkResponse> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  /// Perform DELETE request
  Future<NetworkResponse> delete(String url, {Map<String, String>? headers});

  /// Upload file
  Future<NetworkResponse> upload(
    String url,
    String filePath, {
    Map<String, String>? headers,
  });

  /// Download file
  Future<bool> download(
    String url,
    String savePath, {
    Map<String, String>? headers,
  });
}

/// Network response model
class NetworkResponse {
  const NetworkResponse({
    required this.statusCode,
    required this.data,
    this.headers = const {},
    this.error,
  });

  final int statusCode;
  final dynamic data;
  final Map<String, String> headers;
  final String? error;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
  bool get isError => !isSuccess;
}

/// Network exception for handling errors
class NetworkException implements Exception {
  const NetworkException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'NetworkException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Mock network service for testing
class MockNetworkService implements NetworkService {
  final Map<String, NetworkResponse> _mockResponses = {};

  void addMockResponse(String url, NetworkResponse response) {
    _mockResponses[url] = response;
  }

  @override
  Future<NetworkResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return _getMockResponse(url);
  }

  @override
  Future<NetworkResponse> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    return _getMockResponse(url);
  }

  @override
  Future<NetworkResponse> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    return _getMockResponse(url);
  }

  @override
  Future<NetworkResponse> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    return _getMockResponse(url);
  }

  @override
  Future<NetworkResponse> delete(
    String url, {
    Map<String, String>? headers,
  }) async {
    return _getMockResponse(url);
  }

  @override
  Future<NetworkResponse> upload(
    String url,
    String filePath, {
    Map<String, String>? headers,
  }) async {
    return _getMockResponse(url);
  }

  @override
  Future<bool> download(
    String url,
    String savePath, {
    Map<String, String>? headers,
  }) async {
    return true;
  }

  NetworkResponse _getMockResponse(String url) {
    return _mockResponses[url] ??
        const NetworkResponse(
          statusCode: 404,
          data: {'error': 'Mock response not found'},
          error: 'No mock response configured for this URL',
        );
  }
}
