import 'package:dartz/dartz.dart';
import 'package:tdd_clean/core/error/exception.dart';
import 'package:tdd_clean/core/error/failures.dart';
import 'package:tdd_clean/core/platform/network_info.dart';
import 'package:tdd_clean/features/free_games/data/mappers/domain_game_mapper.dart';
import 'package:tdd_clean/features/free_games/domain/datasources/game_local_data_source.dart';
import 'package:tdd_clean/features/free_games/domain/datasources/game_remote_data_source.dart';
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';
import 'package:tdd_clean/features/free_games/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameRemoteDataSource remoteDataSource;
  final GameLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final DomainGameMapper _mapper;

  GameRepositoryImpl(this.remoteDataSource, this.localDataSource,
      this.networkInfo, this._mapper);

  @override
  Future<Either<Failure, DomainGame>> getGame(int id) async {
    try {
      if (await networkInfo.isConnected) {
        var game = await remoteDataSource.getGame(id);
        return Right(_mapper.unmap(game));
      } else {
        var game = await localDataSource.getLastGame(id);
        return Right(_mapper.unmap(game));
      }
    } catch (e) {
      print(e);
      switch (e.runtimeType) {
        case GameNotFoundException:
          return Left(GameNotFoundFailure());
        case CacheException:
          return Left(CacheFailure());
        case ServerException:
          return Left(ServerFailure());
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<DomainGame>>> getGamesByPlatform(String platform) async {
    try {
      if (await networkInfo.isConnected) {
        var games = await remoteDataSource.getGamesByPlatform(platform);
        return Right(games.map((e) => _mapper.unmap(e)).toList());
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case GameNotFoundException:
          return Left(GameNotFoundFailure());
        case CacheException:
          return Left(CacheFailure());
        case ServerException:
          return Left(ServerFailure());
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<DomainGame>>> getGamesList() async {
    try {
      if (await networkInfo.isConnected) {
        var games = await remoteDataSource.getGamesList();
        return Right(games.map((e) => _mapper.unmap(e)).toList());
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case GameNotFoundException:
          return Left(GameNotFoundFailure());
        case CacheException:
          return Left(CacheFailure());
        case ServerException:
          return Left(ServerFailure());
      }
      return Left(UnknownFailure());
    }
  }
}
