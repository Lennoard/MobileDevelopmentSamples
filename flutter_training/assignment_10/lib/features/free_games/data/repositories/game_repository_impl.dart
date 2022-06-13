import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:tdd_clean/core/error/failures.dart';
import 'package:tdd_clean/features/free_games/data/mappers/game_mapper.dart';
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';
import 'package:tdd_clean/features/free_games/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameMapper _mapper;

  GameRepositoryImpl(this._mapper);

  @override
  Future<Either<Failure, DomainGame>> getGame(int id) async {
    var maybeResponse = await _getResponse("https://www.freetogame.com/api/game?id=$id");
    late Failure failure;
    late http.Response response;

    maybeResponse.fold((l) => failure = l, (r) => response = r);
    if (maybeResponse.isLeft()) {
      return Left(failure);
    }
    return Right(_mapper.map(jsonDecode(response.body)));
  }

  @override
  Future<Either<Failure, List<DomainGame>>> getGamesByPlatform(String platform) async {
    var maybeResponse = await _getResponse("https://www.freetogame.com/api/games?platform=$platform");
    return _handleGamesEither(maybeResponse);
  }

  @override
  Future<Either<Failure, List<DomainGame>>> getGamesList() async {
    var maybeResponse = await _getResponse("https://www.freetogame.com/api/games");
    return _handleGamesEither(maybeResponse);
  }

  Future<Either<Failure, http.Response>> _getResponse(String endpoint) async {
    Either<Failure, http.Response> maybeResponse;
    var response = await http.get(Uri.parse(endpoint));
    var statusCode = response.statusCode;
    if (statusCode != 200) {
      if (statusCode == 404) {
        maybeResponse = Left(GameNotFoundFailure());
      } else {
        maybeResponse = Left(ServerFailure());
      }
    } else {
      maybeResponse = Right(response);
    }
    return maybeResponse;
  }

  Either<Failure, List<DomainGame>> _handleGamesEither(Either<Failure, http.Response> maybeResponse) {
    late Failure failure;
    late http.Response response;

    maybeResponse.fold((l) => failure = l, (r) => response = r);
    if (maybeResponse.isLeft()) {
      return Left(failure);
    }
    return Right(_mapGames(response));
  }

  List<DomainGame> _mapGames(http.Response response) {
    var jsonArray = jsonDecode(response.body) as List;
    return jsonArray.map((e) => _mapper.map(e)).toList();
  }
}
