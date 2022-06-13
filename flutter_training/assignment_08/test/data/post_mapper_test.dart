import 'dart:convert';

import 'package:assignment_07/data/post_mapper.dart';
import 'package:test/test.dart';

void main() {
  final PostMapper _mapper = PostMapper();

  test('given well-formed json when mapped then should return Post', () {
    // Given
    var jsonString = """
    {
      "userId": 420, 
      "id": 69, 
      "title": "New player joins",
      "body": "Lorem ipsum"
    }
    """;
    var json = jsonDecode(jsonString);

    // When
    var result = _mapper.map(json);

    // Then
    expect(result.userId, equals(json['userId']));
    expect(result.id, equals(json['id']));
    expect(result.title, equals(json['title']));
  });
}