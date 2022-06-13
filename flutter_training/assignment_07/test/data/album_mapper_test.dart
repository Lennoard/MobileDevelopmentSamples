import 'dart:convert';

import 'package:assignment_07/data/album_mapper.dart';
import 'package:test/test.dart';

void main() {
  final AlbumMapper _mapper = AlbumMapper();

  test('given well-formed json when mapped then should return Album', () {
    // Given
    var jsonString = '{"userId": 420, "id": 69, "title": "Harry Potter"}';
    var json = jsonDecode(jsonString);

    // When
    var result = _mapper.map(json);

    // Then
    expect(result.userId, equals(json['userId']));
    expect(result.id, equals(json['id']));
    expect(result.title, equals(json['title']));
  });
}