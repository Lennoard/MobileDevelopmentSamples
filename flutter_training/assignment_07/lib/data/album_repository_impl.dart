import 'dart:convert';

import 'package:assignment_07/data/album_mapper.dart';
import 'package:assignment_07/domain/album.dart';
import 'package:assignment_07/domain/album_repository.dart';
import 'package:http/http.dart' as http;

class AlbumRepositoryImpl extends AlbumRepository {
  final AlbumMapper _mapper;

  AlbumRepositoryImpl(this._mapper);

  @override
  Future<List<Album>> getAllAlbums() async {
    var response = await _getResponse('http://jsonplaceholder.typicode.com/albums');
    return mapAlbum(response);
  }

  @override
  Future<List<Album>> getAlbums(int start, int limit) async {
    var response = await _getResponse('http://jsonplaceholder.typicode.com/albums?_start=$start&_limit=$limit');
    return mapAlbum(response);
  }

  Future<http.Response> _getResponse(String endpoint) async {
    var response = await http.get(Uri.parse(endpoint));
    if (response.statusCode != 200) {
      throw Exception('Failed to load album');
    }
    return response;
  }

  List<Album> mapAlbum(http.Response response) {
    var jsonArray = jsonDecode(response.body) as List;
    return jsonArray.map((e) => _mapper.map(e)).toList();
  }
}
