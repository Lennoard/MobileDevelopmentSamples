import 'package:tdd_clean/features/free_games/data/models/game.dart';

abstract class GameLocalDataSource {
  Future<Game> getLastGame(int id);
  Future<void> cacheGame(Game game);
}
