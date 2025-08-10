import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/shared.dart';

import '../../models/post_model.dart';
import '../../repositories/post_repositories.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(this._postRepository) : super(PostInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadPostById>(_onLoadPostById);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
    on<LikePost>(_onLikePost);
    on<UnlikePost>(_onUnlikePost);
    on<SearchPosts>(_onSearchPosts);
    on<PublishPost>(_onPublishPost);
    on<UnpublishPost>(_onUnpublishPost);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading());
      
      final response = await _postRepository.getPosts(
        page: event.page,
        limit: event.limit,
        authorId: event.authorId,
        search: event.search,
        tags: event.tags,
        isPublished: event.isPublished,
        sortBy: event.sortBy,
      );

      if (response.success && response.data != null) {
        final hasReachedMax = response.data!.data.isEmpty || 
                             response.data!.page >= response.data!.totalPages;
        
        emit(PostsLoaded(
          posts: response.data!,
          hasReachedMax: hasReachedMax,
        ));
      } else {
        emit(PostError(response.error ?? 'Failed to load posts'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onLoadPostById(LoadPostById event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading());
      
      final response = await _postRepository.getPostById(event.postId);

      if (response.success && response.data != null) {
        emit(PostLoaded(response.data!));
      } else {
        emit(PostError(response.error ?? 'Failed to load post'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading());
      
      final response = await _postRepository.createPost(event.request);

      if (response.success && response.data != null) {
        emit(PostCreated(response.data!));
      } else {
        emit(PostError(response.error ?? 'Failed to create post'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading());
      
      final response = await _postRepository.updatePost(event.postId, event.request);

      if (response.success && response.data != null) {
        emit(PostUpdated(response.data!));
      } else {
        emit(PostError(response.error ?? 'Failed to update post'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading());
      
      final response = await _postRepository.deletePost(event.postId);

      if (response.success) {
        emit(PostDeleted(event.postId));
      } else {
        emit(PostError(response.error ?? 'Failed to delete post'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onLikePost(LikePost event, Emitter<PostState> emit) async {
    try {
      final response = await _postRepository.likePost(event.postId);

      if (response.success && response.data != null) {
        emit(PostLiked(response.data!));
      } else {
        emit(PostError(response.error ?? 'Failed to like post'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onUnlikePost(UnlikePost event, Emitter<PostState> emit) async {
    try {
      final response = await _postRepository.unlikePost(event.postId);

      if (response.success && response.data != null) {
        emit(PostUnliked(response.data!));
      } else {
        emit(PostError(response.error ?? 'Failed to unlike post'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onSearchPosts(SearchPosts event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading());
      
      final response = await _postRepository.searchPosts(event.query);

      if (response.success && response.data != null) {
        emit(PostsSearched(response.data!));
      } else {
        emit(PostError(response.error ?? 'Failed to search posts'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onPublishPost(PublishPost event, Emitter<PostState> emit) async {
    try {
      final response = await _postRepository.publishPost(event.postId);

      if (response.success && response.data != null) {
        emit(PostPublished(response.data!));
      } else {
        emit(PostError(response.error ?? 'Failed to publish post'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onUnpublishPost(UnpublishPost event, Emitter<PostState> emit) async {
    try {
      final response = await _postRepository.unpublishPost(event.postId);

      if (response.success && response.data != null) {
        emit(PostUnpublished(response.data!));
      } else {
        emit(PostError(response.error ?? 'Failed to unpublish post'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
