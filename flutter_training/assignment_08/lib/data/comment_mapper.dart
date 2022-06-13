import 'package:assignment_07/domain/comment.dart';

class CommentMapper {
  Comment map(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  Map<String, dynamic> unmap(Comment comment) {
    return {
      'postId': comment.postId,
      'id': comment.id,
      'name': comment.name,
      'email': comment.email,
      'body': comment.body
    };
  }
}
