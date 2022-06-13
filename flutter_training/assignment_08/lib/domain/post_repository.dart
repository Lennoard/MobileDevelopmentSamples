import 'package:assignment_07/domain/comment.dart';
import 'package:assignment_07/domain/post.dart';

abstract class PostRepository {
   Future<List<Post>> getAllPosts();
   Future<List<Post>> getPosts(int start, int limit);
   Future<List<Comment>> getComments(int postId);
}
