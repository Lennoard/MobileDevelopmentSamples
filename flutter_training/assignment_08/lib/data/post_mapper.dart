import '../domain/post.dart';

class PostMapper {
  Post map(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> unmap(Post album) {
    return {
      'userId': album.userId,
      'id': album.id,
      'title': album.title,
      'body': album.body
    };
  }
}
