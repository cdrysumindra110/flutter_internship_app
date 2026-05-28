import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../widgets/post_card.dart';
import '../widgets/post_shimmer.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/empty_state.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch posts when screen opens
    context.read<PostBloc>().add(FetchPosts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search posts...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<PostBloc>().add(const SearchPosts(''));
                        },
                      )
                    : null,
              ),
              onChanged: (query) =>
                  context.read<PostBloc>().add(SearchPosts(query)),
            ),
          ),
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                switch (state.status) {
                  case PostStatus.loading:
                    return const PostShimmer();
                  case PostStatus.error:
                    return ErrorState(
                      message: state.errorMessage ?? 'Something went wrong',
                      onRetry: () => context.read<PostBloc>().add(FetchPosts()),
                    );
                  case PostStatus.loaded:
                    if (state.posts.isEmpty) {
                      return const EmptyState(message: 'No posts found');
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<PostBloc>().add(FetchPosts());
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return PostCard(post: state.posts[index]);
                        },
                      ),
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}