import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cubit_sample/models/post.dart';

class NetApi {
  final baseUrl = "https://jsonplaceholder.typicode.com/";

  Future<List<Post>> getPosts() async {
    try {
      final postsRespons = await Dio().get(baseUrl + 'posts');
      return (postsRespons.data as List).map((x) => Post.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
