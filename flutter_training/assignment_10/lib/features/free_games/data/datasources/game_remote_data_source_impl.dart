import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_clean/core/error/exception.dart';
import 'package:tdd_clean/features/free_games/data/mappers/domain_game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/mappers/game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/models/game.dart';
import 'package:tdd_clean/features/free_games/domain/datasources/game_remote_data_source.dart';

class GameRemoteDataSourceImpl implements GameRemoteDataSource {
  final GameMapper _gameMapper;
  final DomainGameMapper _mapper;

  GameRemoteDataSourceImpl(this._gameMapper, this._mapper);


  @override
  Future<Game> getGame(int id) async {
    var response = await _getResponse("https://www.freetogame.com/api/game?id=$id");
    return _mapper.map(_gameMapper.map(jsonDecode(response.body)));
  }

  @override
  Future<List<Game>> getGamesByPlatform(String platform) async {
    var response = await _getResponse("https://www.freetogame.com/api/games?platform=$platform");
    return _mapGames(response);
  }

  @override
  Future<List<Game>> getGamesList() async {
    var response = await _getResponse("https://www.freetogame.com/api/games");
    return _mapGames(response);
  }

  Future<http.Response> _getResponse(String endpoint) async {
    var response = await http.get(Uri.parse(endpoint));
    var statusCode = response.statusCode;
    if (statusCode != 200) {
      if (statusCode == 404) {
        throw GameNotFoundException();
      } else {
        throw ServerException();
      }
    }
    return response;
  }

  List<Game> _mapGames(http.Response response) {
    var jsonArray = jsonDecode(response.body) as List;
    return jsonArray.map((e) => _mapper.map(e)).toList();
  }

}