part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();
  
  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostsLoaded extends PostState {
  final PaginatedResponse<Post> posts;
  final bool hasReachedMax;

  const PostsLoaded({
    required this.posts,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [posts, hasReachedMax];

  PostsLoaded copyWith({
    PaginatedResponse<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostsLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class PostLoaded extends PostState {
  final Post post;

  const PostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

final class PostCreated extends PostState {
  final Post post;

  const PostCreated(this.post);

  @override
  List<Object> get props => [post];
}

final class PostUpdated extends PostState {
  final Post post;

  const PostUpdated(this.post);

  @override
  List<Object> get props => [post];
}

final class PostDeleted extends PostState {
  final String postId;

  const PostDeleted(this.postId);

  @override
  List<Object> get props => [postId];
}

final class PostLiked extends PostState {
  final Post post;

  const PostLiked(this.post);

  @override
  List<Object> get props => [post];
}

final class PostUnliked extends PostState {
  final Post post;

  const PostUnliked(this.post);

  @override
  List<Object> get props => [post];
}

final class PostsSearched extends PostState {
  final List<Post> posts;

  const PostsSearched(this.posts);

  @override
  List<Object> get props => [posts];
}

final class PostPublished extends PostState {
  final Post post;

  const PostPublished(this.post);

  @override
  List<Object> get props => [post];
}

final class PostUnpublished extends PostState {
  final Post post;

  const PostUnpublished(this.post);

  @override
  List<Object> get props => [post];
}

final class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}
