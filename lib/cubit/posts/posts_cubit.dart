import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cubit_sample/data/net_api.dart';
import 'package:flutter_cubit_sample/models/post.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final NetApi _repo;

  PostsCubit(this._repo) : super(PostsInitial());

  void getPosts() async {
    try {
      emit(const PostsLoading());
      final posts = await _repo.getPosts();
      emit(PostsLoaded(posts));
    } catch (error) {
      emit(PostsError(error.toString()));
    }
  }
}
