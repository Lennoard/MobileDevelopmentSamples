import 'dart:convert';

import 'package:assignment_07/data/comment_mapper.dart';
import 'package:assignment_07/data/post_mapper.dart';
import 'package:test/test.dart';

void main() {
  final CommentMapper _mapper = CommentMapper();

  test('given well-formed json when mapped then should return Comment', () {
    // Given
    var jsonString = """
    {
      "postId": 5, 
      "id": 86, 
      "name": "Chris",
      "body": "Should I be here?",
      "email": "somebody@someplace.com"
    }
    """;
    var json = jsonDecode(jsonString);

    // When
    var result = _mapper.map(json);

    // Then
    expect(result.postId, equals(json['postId']));
    expect(result.id, equals(json['id']));
    expect(result.name, equals(json['name']));
    expect(result.body, equals(json['body']));
    expect(result.email, equals(json['email']));
  });
}