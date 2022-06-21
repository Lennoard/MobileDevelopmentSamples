import 'package:tdd_clean/features/free_games/data/models/game.dart';

abstract class GameRemoteDataSource {
  Future<Game> getGame(int id);
  Future<List<Game>> getGamesList();
  Future<List<Game>> getGamesByPlatform(String platform);
}