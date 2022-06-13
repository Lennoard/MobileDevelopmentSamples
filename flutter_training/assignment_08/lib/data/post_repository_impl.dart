import 'dart:convert';

import 'package:assignment_07/data/comment_mapper.dart';
import 'package:assignment_07/data/post_mapper.dart';
import 'package:assignment_07/domain/comment.dart';
import 'package:assignment_07/domain/post.dart';
import 'package:assignment_07/domain/post_repository.dart';
import 'package:http/http.dart' as http;

class PostRepositoryImpl extends PostRepository {
  final PostMapper _mapper;

  PostRepositoryImpl(this._mapper);

  @override
  Future<List<Post>> getAllPosts() async {
    var response = await _getResponse('https://jsonplaceholder.typicode.com/posts');
    return mapPost(response);
  }

  @override
  Future<List<Post>> getPosts(int start, int limit) async {
    var response = await _getResponse('http://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit');
    return mapPost(response);
  }

  @override
  Future<List<Comment>> getComments(int postId) async {
    var response = await _getResponse('https://jsonplaceholder.typicode.com/comments?postId=$postId');
    return mapComment(response);
  }

  Future<http.Response> _getResponse(String endpoint) async {
    var response = await http.get(Uri.parse(endpoint));
    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }
    return response;
  }

  List<Post> mapPost(http.Response response) {
    var jsonArray = jsonDecode(response.body) as List;
    return jsonArray.map((e) => _mapper.map(e)).toList();
  }

  List<Comment> mapComment(http.Response response) {
    var jsonArray = jsonDecode(response.body) as List;
    return jsonArray.map((e) => CommentMapper().map(e)).toList();
  }
}
