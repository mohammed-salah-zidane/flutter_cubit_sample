import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_sample/cubit/posts/posts_cubit.dart';
import 'package:flutter_cubit_sample/data/net_api.dart';
import 'package:flutter_cubit_sample/models/post.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider<PostsCubit>(
        create: (context) => PostsCubit(
          NetApi(),
        )..getPosts(),
        child: BlocConsumer<PostsCubit, PostsState>(
          listener: (
            BuildContext context,
            PostsState state,
          ) {
            if (state is PostsError) {
              showErrorSnackBar(context, state.message);
            }
          },
          builder: (
            BuildContext context,
            PostsState state,
          ) {
            if (state is PostsLoading) {
              return buildLoadingView();
            } else if (state is PostsLoaded) {
              return buildPostsView(state.posts);
            }
            return buildInitialView();
          },
        ),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildInitialView() {
    return Container();
  }

  Widget buildPostsView(List<Post> posts) {
    return ListView.builder(itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          title: Text(posts[index].title ?? ""),
        ),
      );
    });
  }
}
