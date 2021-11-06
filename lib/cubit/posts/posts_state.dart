part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsLoading extends PostsState {
  const PostsLoading();

  @override
  List<Object?> get props => [];
}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object> get props => [message];
}
