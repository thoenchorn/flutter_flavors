class Post {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int likes;
  final int comments;
  final bool isPublished;
  final String? imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.tags,
    required this.createdAt,
    this.updatedAt,
    this.likes = 0,
    this.comments = 0,
    this.isPublished = true,
    this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      isPublished: json['isPublished'] as bool? ?? true,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'likes': likes,
      'comments': comments,
      'isPublished': isPublished,
      'imageUrl': imageUrl,
    };
  }

  Post copyWith({
    String? id,
    String? title,
    String? content,
    String? authorId,
    String? authorName,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likes,
    int? comments,
    bool? isPublished,
    String? imageUrl,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isPublished: isPublished ?? this.isPublished,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title, authorName: $authorName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.authorId == authorId &&
        other.authorName == authorName &&
        other.tags == tags &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.likes == likes &&
        other.comments == comments &&
        other.isPublished == isPublished &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      content,
      authorId,
      authorName,
      tags,
      createdAt,
      updatedAt,
      likes,
      comments,
      isPublished,
      imageUrl,
    );
  }
}

class CreatePostRequest {
  final String title;
  final String content;
  final List<String> tags;
  final bool isPublished;
  final String? imageUrl;

  CreatePostRequest({
    required this.title,
    required this.content,
    required this.tags,
    this.isPublished = true,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'tags': tags,
      'isPublished': isPublished,
      'imageUrl': imageUrl,
    };
  }
}

class UpdatePostRequest {
  final String? title;
  final String? content;
  final List<String>? tags;
  final bool? isPublished;
  final String? imageUrl;

  UpdatePostRequest({
    this.title,
    this.content,
    this.tags,
    this.isPublished,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (title != null) json['title'] = title;
    if (content != null) json['content'] = content;
    if (tags != null) json['tags'] = tags;
    if (isPublished != null) json['isPublished'] = isPublished;
    if (imageUrl != null) json['imageUrl'] = imageUrl;
    return json;
  }
}
