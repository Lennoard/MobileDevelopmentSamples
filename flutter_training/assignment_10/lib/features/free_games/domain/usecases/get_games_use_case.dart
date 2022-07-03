import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean/core/usecases/usecase.dart';
import 'package:tdd_clean/features/free_games/data/models/game.dart';
import 'package:tdd_clean/features/free_games/domain/repositories/game_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/mappers/domain_game_mapper.dart';

class GetGamesUseCase extends UseCase<List<Game>, Params> {
  final GameRepository _gameRepository;
  final DomainGameMapper _gameMapper;

  GetGamesUseCase(this._gameRepository, this._gameMapper);

  @override
  Future<Either<Failure, List<Game>>> call(Params params) async {
    var domainGames = await _gameRepository.getGamesList();
    return domainGames.map((list) =>
        list.map((game) => _gameMapper.map(game)).toList()
    );
  }
}

class Params extends Equatable {
  final String platform;

  const Params({required this.platform}) : super();

  @override
  List<Object?> get props => [platform];
}
