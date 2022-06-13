import 'package:dartz/dartz.dart';
import 'package:tdd_clean/core/error/failures.dart';
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';

abstract class GameRepository {
  Future<Either<Failure, DomainGame>> getGame(int id);
  Future<Either<Failure, List<DomainGame>>> getGamesList();
  Future<Either<Failure, List<DomainGame>>> getGamesByPlatform(String platform);
}