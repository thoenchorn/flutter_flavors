import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

import '../models/post_model.dart';
import '../provider/http/http_client.dart';

/// Post repository for managing post-related operations
class PostRepository {
  final HttpClient _httpClient;

  PostRepository(this._httpClient);

  /// Get all posts with pagination and filters
  Future<ApiResponse<PaginatedResponse<Post>>> getPosts({
    int page = 1,
    int limit = 10,
    String? authorId,
    String? search,
    List<String>? tags,
    bool? isPublished,
    String? sortBy,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      
      if (authorId != null) queryParams['authorId'] = authorId;
      if (search != null) queryParams['search'] = search;
      if (tags != null) queryParams['tags'] = tags.join(',');
      if (isPublished != null) queryParams['isPublished'] = isPublished;
      if (sortBy != null) queryParams['sort'] = sortBy;

      final response = await _httpClient.get('/posts', queryParameters: queryParams);
      return _parsePaginatedPostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Get post by ID
  Future<ApiResponse<Post>> getPostById(String postId) async {
    try {
      final response = await _httpClient.get('/posts/$postId');
      return _parsePostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Get posts by author
  Future<ApiResponse<PaginatedResponse<Post>>> getPostsByAuthor(
    String authorId, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      final response = await _httpClient.get(
        '/posts/author/$authorId',
        queryParameters: queryParams,
      );
      return _parsePaginatedPostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Create new post
  Future<ApiResponse<Post>> createPost(CreatePostRequest request) async {
    try {
      final response = await _httpClient.post(
        '/posts',
        body: request.toJson(),
      );
      return _parsePostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Update post
  Future<ApiResponse<Post>> updatePost(String postId, UpdatePostRequest request) async {
    try {
      final response = await _httpClient.put(
        '/posts/$postId',
        body: request.toJson(),
      );
      return _parsePostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Delete post
  Future<ApiResponse<void>> deletePost(String postId) async {
    try {
      await _httpClient.delete('/posts/$postId');
      return ApiResponse.success(data: null);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Like post
  Future<ApiResponse<Post>> likePost(String postId) async {
    try {
      final response = await _httpClient.post('/posts/$postId/like');
      return _parsePostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Unlike post
  Future<ApiResponse<Post>> unlikePost(String postId) async {
    try {
      final response = await _httpClient.delete('/posts/$postId/like');
      return _parsePostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Search posts
  Future<ApiResponse<List<Post>>> searchPosts(String query) async {
    try {
      final response = await _httpClient.get(
        '/posts/search',
        queryParameters: {'q': query},
      );
      return _parsePostListResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Get posts by tags
  Future<ApiResponse<List<Post>>> getPostsByTags(List<String> tags) async {
    try {
      final response = await _httpClient.get(
        '/posts/tags',
        queryParameters: {'tags': tags.join(',')},
      );
      return _parsePostListResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Publish post
  Future<ApiResponse<Post>> publishPost(String postId) async {
    try {
      final response = await _httpClient.patch(
        '/posts/$postId/publish',
        body: {'isPublished': true},
      );
      return _parsePostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Unpublish post
  Future<ApiResponse<Post>> unpublishPost(String postId) async {
    try {
      final response = await _httpClient.patch(
        '/posts/$postId/publish',
        body: {'isPublished': false},
      );
      return _parsePostResponse(response);
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  /// Upload post image
  Future<ApiResponse<String>> uploadPostImage(String postId, List<int> imageBytes) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse('${_httpClient.baseUrl}/posts/$postId/image'));
      
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'post_image.jpg',
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiResponse.success(data: jsonData['imageUrl'] as String);
      } else {
        return ApiResponse.error(error: 'Upload failed');
      }
    } catch (e) {
      return ApiResponse.error(error: e.toString());
    }
  }

  ApiResponse<Post> _parsePostResponse(Map<String, dynamic> response) {
    try {
      final post = Post.fromJson(response['data'] ?? response);
      return ApiResponse.success(data: post);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse post response: $e');
    }
  }

  ApiResponse<List<Post>> _parsePostListResponse(Map<String, dynamic> response) {
    try {
      final posts = (response['data'] as List<dynamic>)
          .map((json) => Post.fromJson(json))
          .toList();
      return ApiResponse.success(data: posts);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse post list response: $e');
    }
  }

  ApiResponse<PaginatedResponse<Post>> _parsePaginatedPostResponse(Map<String, dynamic> response) {
    try {
      final paginatedResponse = PaginatedResponse.fromJson(
        response,
        (json) => Post.fromJson(json),
      );
      return ApiResponse.success(data: paginatedResponse);
    } catch (e) {
      return ApiResponse.error(error: 'Failed to parse paginated response: $e');
    }
  }
}
