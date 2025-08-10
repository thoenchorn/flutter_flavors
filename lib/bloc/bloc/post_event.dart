part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class LoadPosts extends PostEvent {
  final int page;
  final int limit;
  final String? authorId;
  final String? search;
  final List<String>? tags;
  final bool? isPublished;
  final String? sortBy;

  const LoadPosts({
    this.page = 1,
    this.limit = 10,
    this.authorId,
    this.search,
    this.tags,
    this.isPublished,
    this.sortBy,
  });

  @override
  List<Object> get props => [page, limit, authorId ?? '', search ?? '', tags ?? [], isPublished ?? false, sortBy ?? ''];
}

final class LoadPostById extends PostEvent {
  final String postId;

  const LoadPostById(this.postId);

  @override
  List<Object> get props => [postId];
}

final class CreatePost extends PostEvent {
  final CreatePostRequest request;

  const CreatePost(this.request);

  @override
  List<Object> get props => [request];
}

final class UpdatePost extends PostEvent {
  final String postId;
  final UpdatePostRequest request;

  const UpdatePost(this.postId, this.request);

  @override
  List<Object> get props => [postId, request];
}

final class DeletePost extends PostEvent {
  final String postId;

  const DeletePost(this.postId);

  @override
  List<Object> get props => [postId];
}

final class LikePost extends PostEvent {
  final String postId;

  const LikePost(this.postId);

  @override
  List<Object> get props => [postId];
}

final class UnlikePost extends PostEvent {
  final String postId;

  const UnlikePost(this.postId);

  @override
  List<Object> get props => [postId];
}

final class SearchPosts extends PostEvent {
  final String query;

  const SearchPosts(this.query);

  @override
  List<Object> get props => [query];
}

final class PublishPost extends PostEvent {
  final String postId;

  const PublishPost(this.postId);

  @override
  List<Object> get props => [postId];
}

final class UnpublishPost extends PostEvent {
  final String postId;

  const UnpublishPost(this.postId);

  @override
  List<Object> get props => [postId];
}
