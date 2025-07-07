/// Result type for handling success and failure states
abstract class Result<T> {
  const Result();

  /// Create a success result
  factory Result.success(T data) = Success<T>;

  /// Create a failure result
  factory Result.failure(String error, {int? code}) = Failure<T>;

  /// Check if result is success
  bool get isSuccess => this is Success<T>;

  /// Check if result is failure
  bool get isFailure => this is Failure<T>;

  /// Get data if success, null otherwise
  T? get data => isSuccess ? (this as Success<T>).data : null;

  /// Get error message if failure, null otherwise
  String? get error => isFailure ? (this as Failure<T>).error : null;

  /// Get error code if failure, null otherwise
  int? get errorCode => isFailure ? (this as Failure<T>).code : null;

  /// Map the result data to a new type
  Result<R> map<R>(R Function(T data) transform) {
    if (isSuccess) {
      return Result.success(transform((this as Success<T>).data));
    } else {
      final failure = this as Failure<T>;
      return Result.failure(failure.error, code: failure.code);
    }
  }

  /// Handle both success and failure cases
  R when<R>({
    required R Function(T data) success,
    required R Function(String error, int? code) failure,
  }) {
    if (isSuccess) {
      return success((this as Success<T>).data);
    } else {
      final fail = this as Failure<T>;
      return failure(fail.error, fail.code);
    }
  }

  /// Execute function only if result is success
  Result<T> onSuccess(void Function(T data) callback) {
    if (isSuccess) {
      callback((this as Success<T>).data);
    }
    return this;
  }

  /// Execute function only if result is failure
  Result<T> onFailure(void Function(String error, int? code) callback) {
    if (isFailure) {
      final failure = this as Failure<T>;
      callback(failure.error, failure.code);
    }
    return this;
  }
}

/// Success result
class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  String toString() => 'Success($data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

/// Failure result
class Failure<T> extends Result<T> {
  const Failure(this.error, {this.code});

  final String error;
  final int? code;

  @override
  String toString() => 'Failure($error${code != null ? ', code: $code' : ''})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          code == other.code;

  @override
  int get hashCode => error.hashCode ^ code.hashCode;
}
