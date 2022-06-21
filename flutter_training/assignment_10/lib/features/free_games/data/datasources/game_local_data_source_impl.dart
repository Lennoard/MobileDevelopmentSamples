import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean/features/free_games/data/mappers/domain_game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/mappers/game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/models/game.dart';
import 'package:tdd_clean/features/free_games/domain/datasources/game_local_data_source.dart';
import 'dart:convert';

class GameLocalDataSourceImpl implements GameLocalDataSource {
  final SharedPreferences _prefs;
  final GameMapper _gameMapper;
  final DomainGameMapper _mapper;

  GameLocalDataSourceImpl(this._prefs, this._gameMapper, this._mapper);

  @override
  Future<void> cacheGame(Game game) async {
    await _prefs.setString(gameKey, json.encode(game));
  }

  @override
  Future<Game> getLastGame(int id) async {
    String cached = _prefs.getString(gameKey) ?? '{}';
    var decoded = json.decode(cached) as Map<String, dynamic>;

    return _mapper.map(_gameMapper.map(decoded));
  }

  static const gameKey = "last_game";
}
