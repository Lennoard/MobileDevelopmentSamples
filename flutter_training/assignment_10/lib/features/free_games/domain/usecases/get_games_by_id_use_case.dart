import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean/core/usecases/usecase.dart';
import 'package:tdd_clean/features/free_games/data/models/game.dart';
import 'package:tdd_clean/features/free_games/domain/repositories/game_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/mappers/domain_game_mapper.dart';

class GetGameByIdUseCase extends UseCase<Game, Params> {
  final GameRepository _gameRepository;
  final DomainGameMapper _gameMapper;

  GetGameByIdUseCase(this._gameRepository, this._gameMapper);

  @override
  Future<Either<Failure, Game>> call(Params params) async {
    var domainGames = await _gameRepository.getGame(params.id);
    return domainGames.map((domainGame) => _gameMapper.map(domainGame));
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id}) : super();

  @override
  List<Object?> get props => [id];
}

