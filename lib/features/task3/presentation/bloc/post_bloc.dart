import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/services/post_service.dart';
import '../../domain/models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService postService;
  List<Post> _allPosts = [];

  PostBloc({required this.postService}) : super(const PostState()) {
    on<FetchPosts>(_onFetchPosts);
    on<SearchPosts>(_onSearchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      _allPosts = await postService.fetchPosts();
      emit(state.copyWith(status: PostStatus.loaded, posts: _allPosts));
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onSearchPosts(SearchPosts event, Emitter<PostState> emit) {
    if (state.status != PostStatus.loaded) return;
    final query = event.query.toLowerCase();
    final filtered = _allPosts.where((post) {
      return post.title.toLowerCase().contains(query) ||
          post.body.toLowerCase().contains(query);
    }).toList();
    emit(state.copyWith(posts: filtered));
  }
}
