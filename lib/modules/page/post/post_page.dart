import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../bloc/bloc/post_bloc.dart';
import '../../../models/post_model.dart';
import '../../../repositories/post_repositories.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        context.read<PostRepository>(),
      )..add(const LoadPosts()),
      child: const PostView(),
    );
  }
}

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMorePosts();
    }
  }

  void _loadMorePosts() {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });
      
      context.read<PostBloc>().add(LoadPosts(page: _currentPage));
    }
  }

  void _searchPosts(String query) {
    if (query.isNotEmpty) {
      context.read<PostBloc>().add(SearchPosts(query));
    } else {
      context.read<PostBloc>().add(const LoadPosts());
    }
  }

  void _createPost() {
    showDialog(
      context: context,
      builder: (context) => const CreatePostDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () => context.read<PostBloc>().add(const LoadPosts()),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search posts...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    _searchPosts('');
                  },
                  icon: const Icon(Icons.clear),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: _searchPosts,
            ),
          ),
          
          // Posts List
          Expanded(
            child: BlocConsumer<PostBloc, PostState>(
              listener: (context, state) {
                if (state is PostError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is PostCreated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Post "${state.post.title}" created successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context); // Close create dialog
                } else if (state is PostDeleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Post deleted successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                
                // Reset loading more flag
                if (state is PostsLoaded) {
                  setState(() {
                    _isLoadingMore = false;
                  });
                }
              },
              builder: (context, state) {
                if (state is PostLoading && _currentPage == 1) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostsLoaded) {
                  return _buildPostsList(state.posts);
                } else if (state is PostsSearched) {
                  return _buildSearchResults(state.posts);
                } else if (state is PostError && _currentPage == 1) {
                  return _buildErrorWidget(state.message);
                } else {
                  return const Center(child: Text('No posts found'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createPost,
        tooltip: 'Create Post',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPostsList(PaginatedResponse<Post> posts) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: posts.data.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= posts.data.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        final post = posts.data[index];
        return _buildPostCard(post);
      },
    );
  }

  Widget _buildSearchResults(List<Post> posts) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return _buildPostCard(post);
      },
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          post.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              post.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  post.authorName,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const Spacer(),
                Icon(Icons.favorite, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${post.likes}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.comment, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${post.comments}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            if (post.tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                children: post.tags.map((tag) => Chip(
                  label: Text(tag),
                  backgroundColor: Colors.blue[100],
                  labelStyle: TextStyle(color: Colors.blue[800]),
                )).toList(),
              ),
            ],
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handlePostAction(value, post),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.visibility),
                  SizedBox(width: 8),
                  Text('View'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'like',
              child: Row(
                children: [
                  Icon(Icons.favorite),
                  SizedBox(width: 8),
                  Text('Like'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
        onTap: () => _viewPost(post),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () => context.read<PostBloc>().add(const LoadPosts()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _handlePostAction(String action, Post post) {
    switch (action) {
      case 'view':
        _viewPost(post);
        break;
      case 'edit':
        _editPost(post);
        break;
      case 'like':
        context.read<PostBloc>().add(LikePost(post.id));
        break;
      case 'delete':
        _deletePost(post);
        break;
    }
  }

  void _viewPost(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailPage(post: post),
      ),
    );
  }

  void _editPost(Post post) {
    showDialog(
      context: context,
      builder: (context) => EditPostDialog(post: post),
    );
  }

  void _deletePost(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: Text('Are you sure you want to delete "${post.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<PostBloc>().add(DeletePost(post.id));
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({super.key});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();
  bool _isPublished = true;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _createPost() {
    if (_formKey.currentState!.validate()) {
      final tags = _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList();

      final request = CreatePostRequest(
        title: _titleController.text,
        content: _contentController.text,
        tags: tags,
        isPublished: _isPublished,
      );

      context.read<PostBloc>().add(CreatePost(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Post'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags (comma-separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Published'),
                value: _isPublished,
                onChanged: (value) {
                  setState(() {
                    _isPublished = value ?? true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _createPost,
          child: const Text('Create'),
        ),
      ],
    );
  }
}

class EditPostDialog extends StatefulWidget {
  final Post post;

  const EditPostDialog({super.key, required this.post});

  @override
  State<EditPostDialog> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final TextEditingController _tagsController;
  late bool _isPublished;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _contentController = TextEditingController(text: widget.post.content);
    _tagsController = TextEditingController(text: widget.post.tags.join(', '));
    _isPublished = widget.post.isPublished;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _updatePost() {
    if (_formKey.currentState!.validate()) {
      final tags = _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList();

      final request = UpdatePostRequest(
        title: _titleController.text,
        content: _contentController.text,
        tags: tags,
        isPublished: _isPublished,
      );

      context.read<PostBloc>().add(UpdatePost(widget.post.id, request));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Post'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags (comma-separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Published'),
                value: _isPublished,
                onChanged: (value) {
                  setState(() {
                    _isPublished = value ?? true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _updatePost,
          child: const Text('Update'),
        ),
      ],
    );
  }
}

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              context.read<PostBloc>().add(LikePost(post.id));
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.imageUrl != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.imageUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 64),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              post.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  post.authorName,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const Spacer(),
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  _formatDate(post.createdAt),
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              post.content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.favorite, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${post.likes} likes',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.comment, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${post.comments} comments',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            if (post.tags.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: post.tags.map((tag) => Chip(
                  label: Text(tag),
                  backgroundColor: Colors.blue[100],
                  labelStyle: TextStyle(color: Colors.blue[800]),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
