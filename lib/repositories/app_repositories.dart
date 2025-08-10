import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

import '../provider/http/http_client.dart';

/// Base repository interface for common CRUD operations
abstract class BaseRepository<T> {
  Future<ApiResponse<List<T>>> getAll({int page = 1, int limit = 10});
  Future<ApiResponse<T>> getById(String id);
  Future<ApiResponse<T>> create(T item);
  Future<ApiResponse<T>> update(String id, T item);
  Future<ApiResponse<void>> delete(String id);
}

/// User repository for managing user-related operations
class UserRepository {
  final HttpClient _httpClient;

  UserRepository(this._httpClient);

  /// Get current user profile
  Future<ApiResponse<User>> getCurrentUser() async {
    try {
      final response = await _httpClient.get('/user/profile');
      return _parseUserResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Get all users with pagination
  Future<ApiResponse<PaginatedResponse<User>>> getUsers({
    int page = 1,
    int limit = 10,
    String? search,
    String? sortBy,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      
      if (search != null) queryParams['search'] = search;
      if (sortBy != null) queryParams['sort'] = sortBy;

      final response = await _httpClient.get('/users', queryParameters: queryParams);
      return _parsePaginatedUserResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Get user by ID
  Future<ApiResponse<User>> getUserById(String userId) async {
    try {
      final response = await _httpClient.get('/users/$userId');
      return _parseUserResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Create new user
  Future<ApiResponse<User>> createUser(CreateUserRequest request) async {
    try {
      final response = await _httpClient.post(
        '/users',
        body: request.toJson(),
      );
      return _parseUserResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Update user
  Future<ApiResponse<User>> updateUser(String userId, UpdateUserRequest request) async {
    try {
      final response = await _httpClient.put(
        '/users/$userId',
        body: request.toJson(),
      );
      return _parseUserResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Delete user
  Future<ApiResponse<void>> deleteUser(String userId) async {
    try {
      await _httpClient.delete('/users/$userId');
      return ApiResponse.success(data: null);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Upload user avatar
  Future<ApiResponse<String>> uploadAvatar(String userId, List<int> imageBytes) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse('${_httpClient.baseUrl}/users/$userId/avatar'));
      
      request.files.add(http.MultipartFile.fromBytes(
        'avatar',
        imageBytes,
        filename: 'avatar.jpg',
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiResponse.success(data: jsonData['avatarUrl'] as String);
      } else {
        return ApiResponse.error(error: 'Upload failed');
      }
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  ApiResponse<User> _parseUserResponse(Map<String, dynamic> response) {
    try {
      final user = User.fromJson(response['data'] ?? response);
      return ApiResponse.success(data: user);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse user response: $e');
    }
  }

  ApiResponse<PaginatedResponse<User>> _parsePaginatedUserResponse(Map<String, dynamic> response) {
    try {
      final paginatedResponse = PaginatedResponse.fromJson(
        response,
        (json) => User.fromJson(json),
      );
      return ApiResponse.success(data: paginatedResponse);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse paginated response: $e');
    }
  }
}

/// Product repository for managing product-related operations
class ProductRepository {
  final HttpClient _httpClient;

  ProductRepository(this._httpClient);

  /// Get all products with filters
  Future<ApiResponse<PaginatedResponse<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      
      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;
      if (minPrice != null) queryParams['minPrice'] = minPrice;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;
      if (sortBy != null) queryParams['sort'] = sortBy;

      final response = await _httpClient.get('/products', queryParameters: queryParams);
      return _parsePaginatedProductResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Get product by ID
  Future<ApiResponse<Product>> getProductById(String productId) async {
    try {
      final response = await _httpClient.get('/products/$productId');
      return _parseProductResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Get products by category
  Future<ApiResponse<List<Product>>> getProductsByCategory(String category) async {
    try {
      final response = await _httpClient.get('/products/category/$category');
      return _parseProductListResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Create new product
  Future<ApiResponse<Product>> createProduct(CreateProductRequest request) async {
    try {
      final response = await _httpClient.post(
        '/products',
        body: request.toJson(),
      );
      return _parseProductResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Update product
  Future<ApiResponse<Product>> updateProduct(String productId, UpdateProductRequest request) async {
    try {
      final response = await _httpClient.put(
        '/products/$productId',
        body: request.toJson(),
      );
      return _parseProductResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Delete product
  Future<ApiResponse<void>> deleteProduct(String productId) async {
    try {
      await _httpClient.delete('/products/$productId');
      return ApiResponse.success(data: null);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Search products
  Future<ApiResponse<List<Product>>> searchProducts(String query) async {
    try {
      final response = await _httpClient.get('/products/search', queryParameters: {'q': query});
      return _parseProductListResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  ApiResponse<Product> _parseProductResponse(Map<String, dynamic> response) {
    try {
      final product = Product.fromJson(response['data'] ?? response);
      return ApiResponse.success(data: product);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse product response: $e');
    }
  }

  ApiResponse<List<Product>> _parseProductListResponse(Map<String, dynamic> response) {
    try {
      final products = (response['data'] as List<dynamic>)
          .map((json) => Product.fromJson(json))
          .toList();
      return ApiResponse.success(data: products);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse product list response: $e');
    }
  }

  ApiResponse<PaginatedResponse<Product>> _parsePaginatedProductResponse(Map<String, dynamic> response) {
    try {
      final paginatedResponse = PaginatedResponse.fromJson(
        response,
        (json) => Product.fromJson(json),
      );
      return ApiResponse.success(data: paginatedResponse);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse paginated response: $e');
    }
  }
}

/// Authentication repository for managing authentication operations
class AuthRepository {
  final HttpClient _httpClient;

  AuthRepository(this._httpClient);

  /// Login user
  Future<ApiResponse<AuthResponse>> login(LoginRequest request) async {
    try {
      final response = await _httpClient.post(
        '/auth/login',
        body: request.toJson(),
      );
      return _parseAuthResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Register user
  Future<ApiResponse<AuthResponse>> register(RegisterRequest request) async {
    try {
      final response = await _httpClient.post(
        '/auth/register',
        body: request.toJson(),
      );
      return _parseAuthResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Logout user
  Future<ApiResponse<void>> logout() async {
    try {
      await _httpClient.post('/auth/logout');
      return ApiResponse.success(data: null);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Refresh token
  Future<ApiResponse<AuthResponse>> refreshToken(String refreshToken) async {
    try {
      final response = await _httpClient.post(
        '/auth/refresh',
        body: {'refreshToken': refreshToken},
      );
      return _parseAuthResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Forgot password
  Future<ApiResponse<void>> forgotPassword(String email) async {
    try {
      await _httpClient.post(
        '/auth/forgot-password',
        body: {'email': email},
      );
      return ApiResponse.success(data: null);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Reset password
  Future<ApiResponse<void>> resetPassword(ResetPasswordRequest request) async {
    try {
      await _httpClient.post(
        '/auth/reset-password',
        body: request.toJson(),
      );
      return ApiResponse.success(data: null);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Verify email
  Future<ApiResponse<void>> verifyEmail(String token) async {
    try {
      await _httpClient.post(
        '/auth/verify-email',
        body: {'token': token},
      );
      return ApiResponse.success(data: null);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  ApiResponse<AuthResponse> _parseAuthResponse(Map<String, dynamic> response) {
    try {
      final authResponse = AuthResponse.fromJson(response['data'] ?? response);
      return ApiResponse.success(data: authResponse);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse auth response: $e');
    }
  }
}

/// Order repository for managing order-related operations
class OrderRepository {
  final HttpClient _httpClient;

  OrderRepository(this._httpClient);

  /// Get user orders
  Future<ApiResponse<PaginatedResponse<Order>>> getUserOrders({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      
      if (status != null) queryParams['status'] = status;

      final response = await _httpClient.get('/orders', queryParameters: queryParams);
      return _parsePaginatedOrderResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Get order by ID
  Future<ApiResponse<Order>> getOrderById(String orderId) async {
    try {
      final response = await _httpClient.get('/orders/$orderId');
      return _parseOrderResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Create new order
  Future<ApiResponse<Order>> createOrder(CreateOrderRequest request) async {
    try {
      final response = await _httpClient.post(
        '/orders',
        body: request.toJson(),
      );
      return _parseOrderResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Cancel order
  Future<ApiResponse<Order>> cancelOrder(String orderId) async {
    try {
      final response = await _httpClient.patch(
        '/orders/$orderId/cancel',
      );
      return _parseOrderResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Update order status
  Future<ApiResponse<Order>> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await _httpClient.patch(
        '/orders/$orderId/status',
        body: {'status': status},
      );
      return _parseOrderResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  ApiResponse<Order> _parseOrderResponse(Map<String, dynamic> response) {
    try {
      final order = Order.fromJson(response['data'] ?? response);
      return ApiResponse.success(data: order);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse order response: $e');
    }
  }

  ApiResponse<PaginatedResponse<Order>> _parsePaginatedOrderResponse(Map<String, dynamic> response) {
    try {
      final paginatedResponse = PaginatedResponse.fromJson(
        response,
        (json) => Order.fromJson(json),
      );
      return ApiResponse.success(data: paginatedResponse);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse paginated response: $e');
    }
  }
}

// Example Models (you would replace these with your actual models)

class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class CreateUserRequest {
  final String name;
  final String email;
  final String password;

  CreateUserRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

class UpdateUserRequest {
  final String? name;
  final String? email;

  UpdateUserRequest({
    this.name,
    this.email,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null) json['name'] = name;
    if (email != null) json['email'] = email;
    return json;
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final int stock;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    required this.stock,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      images: List<String>.from(json['images']),
      stock: json['stock'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'images': images,
      'stock': stock,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class CreateProductRequest {
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final int stock;

  CreateProductRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    required this.stock,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'images': images,
      'stock': stock,
    };
  }
}

class UpdateProductRequest {
  final String? name;
  final String? description;
  final double? price;
  final String? category;
  final List<String>? images;
  final int? stock;

  UpdateProductRequest({
    this.name,
    this.description,
    this.price,
    this.category,
    this.images,
    this.stock,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null) json['name'] = name;
    if (description != null) json['description'] = description;
    if (price != null) json['price'] = price;
    if (category != null) json['category'] = category;
    if (images != null) json['images'] = images;
    if (stock != null) json['stock'] = stock;
    return json;
  }
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final User user;
  final DateTime expiresAt;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.expiresAt,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: User.fromJson(json['user']),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class RegisterRequest {
  final String name;
  final String email;
  final String password;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

class ResetPasswordRequest {
  final String token;
  final String newPassword;

  ResetPasswordRequest({
    required this.token,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'newPassword': newPassword,
    };
  }
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}

class CreateOrderRequest {
  final List<CreateOrderItemRequest> items;

  CreateOrderRequest({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CreateOrderItemRequest {
  final String productId;
  final int quantity;

  CreateOrderItemRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
