part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class FetchPosts extends PostEvent {}

class SearchPosts extends PostEvent {
  final String query;

  const SearchPosts(this.query);

  @override
  List<Object?> get props => [query];
}
