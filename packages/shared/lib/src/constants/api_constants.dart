/// API-related constants
class ApiConstants {
  ApiConstants._();

  // HTTP Methods
  static const String methodGet = 'GET';
  static const String methodPost = 'POST';
  static const String methodPut = 'PUT';
  static const String methodPatch = 'PATCH';
  static const String methodDelete = 'DELETE';

  // HTTP Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAuthorization = 'Authorization';
  static const String headerAccept = 'Accept';
  static const String headerUserAgent = 'User-Agent';
  static const String headerCacheControl = 'Cache-Control';

  // Content Types
  static const String contentTypeJson = 'application/json';
  static const String contentTypeFormData = 'multipart/form-data';
  static const String contentTypeFormUrlEncoded =
      'application/x-www-form-urlencoded';

  // HTTP Status Codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusConflict = 409;
  static const int statusUnprocessableEntity = 422;
  static const int statusInternalServerError = 500;
  static const int statusBadGateway = 502;
  static const int statusServiceUnavailable = 503;

  // API Endpoints (these would be environment-specific)
  static const String endpointAuth = '/auth';
  static const String endpointLogin = '/auth/login';
  static const String endpointLogout = '/auth/logout';
  static const String endpointRegister = '/auth/register';
  static const String endpointProfile = '/user/profile';
  static const String endpointUsers = '/users';

  // Query Parameters
  static const String paramPage = 'page';
  static const String paramLimit = 'limit';
  static const String paramSort = 'sort';
  static const String paramFilter = 'filter';
  static const String paramSearch = 'search';

  // Error Messages
  static const String errorNetworkTimeout = 'Network timeout';
  static const String errorNoInternet = 'No internet connection';
  static const String errorServerError = 'Server error occurred';
  static const String errorUnauthorized = 'Unauthorized access';
  static const String errorForbidden = 'Access forbidden';
  static const String errorNotFound = 'Resource not found';
  static const String errorBadRequest = 'Bad request';
  static const String errorUnknown = 'Unknown error occurred';
}
