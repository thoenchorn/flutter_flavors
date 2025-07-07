/// Generic API response model for consistent response handling
class ApiResponse<T> {
  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
    this.code,
    this.metadata = const {},
  });

  final bool success;
  final T? data;
  final String? message;
  final String? error;
  final int? code;
  final Map<String, dynamic> metadata;

  /// Create successful response
  factory ApiResponse.success({
    required T data,
    String? message,
    int? code,
    Map<String, dynamic> metadata = const {},
  }) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
      code: code,
      metadata: metadata,
    );
  }

  /// Create error response
  factory ApiResponse.error({
    required String error,
    String? message,
    int? code,
    Map<String, dynamic> metadata = const {},
  }) {
    return ApiResponse<T>(
      success: false,
      error: error,
      message: message,
      code: code,
      metadata: metadata,
    );
  }

  /// Create from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      code: json['code'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson([dynamic Function(T)? toJsonT]) {
    return {
      'success': success,
      'data': data != null && toJsonT != null ? toJsonT(data as T) : data,
      'message': message,
      'error': error,
      'code': code,
      'metadata': metadata,
    };
  }

  /// Check if response has data
  bool get hasData => data != null;

  /// Check if response has error
  bool get hasError => error != null;

  /// Get data or throw exception if error
  T get dataOrThrow {
    if (!success || hasError) {
      throw ApiException(error ?? 'Unknown error', code: code);
    }
    if (data == null) {
      throw ApiException('No data available', code: code);
    }
    return data as T;
  }

  @override
  String toString() =>
      'ApiResponse(success: $success, data: $data, error: $error)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiResponse<T> &&
          runtimeType == other.runtimeType &&
          success == other.success &&
          data == other.data &&
          message == other.message &&
          error == other.error &&
          code == other.code;

  @override
  int get hashCode =>
      success.hashCode ^
      data.hashCode ^
      message.hashCode ^
      error.hashCode ^
      code.hashCode;
}

/// API exception for handling API errors
class ApiException implements Exception {
  const ApiException(this.message, {this.code});

  final String message;
  final int? code;

  @override
  String toString() =>
      'ApiException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Paginated API response for list data
class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.data,
    required this.page,
    required this.totalPages,
    required this.totalItems,
    required this.hasNext,
    required this.hasPrevious,
    this.limit,
  });

  final List<T> data;
  final int page;
  final int totalPages;
  final int totalItems;
  final bool hasNext;
  final bool hasPrevious;
  final int? limit;

  /// Create from JSON
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    final dataList = json['data'] as List<dynamic>? ?? [];
    return PaginatedResponse<T>(
      data: dataList.map(fromJsonT).toList(),
      page: json['page'] as int? ?? 1,
      totalPages: json['totalPages'] as int? ?? 1,
      totalItems: json['totalItems'] as int? ?? 0,
      hasNext: json['hasNext'] as bool? ?? false,
      hasPrevious: json['hasPrevious'] as bool? ?? false,
      limit: json['limit'] as int?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson([dynamic Function(T)? toJsonT]) {
    return {
      'data': toJsonT != null ? data.map(toJsonT).toList() : data,
      'page': page,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'hasNext': hasNext,
      'hasPrevious': hasPrevious,
      'limit': limit,
    };
  }

  /// Check if response is empty
  bool get isEmpty => data.isEmpty;

  /// Check if response is not empty
  bool get isNotEmpty => data.isNotEmpty;

  @override
  String toString() =>
      'PaginatedResponse(page: $page, totalItems: $totalItems, items: ${data.length})';
}
