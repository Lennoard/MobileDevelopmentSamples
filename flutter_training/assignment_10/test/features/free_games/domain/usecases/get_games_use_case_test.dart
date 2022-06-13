import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean/core/error/failures.dart';
import 'package:tdd_clean/features/free_games/data/mappers/domain_game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/mappers/game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/models/game.dart';
import 'package:tdd_clean/features/free_games/data/models/system_requirement.dart';
import 'package:tdd_clean/features/free_games/data/repositories/game_repository_impl.dart';
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';
import 'package:tdd_clean/features/free_games/domain/usecases/get_games_use_case.dart';

import '../repositories/get_games_repository_test.mocks.dart';

@GenerateMocks([GameRepositoryImpl, GameMapper, DomainGameMapper])

void main() {
  late MockGameRepositoryImpl repository;
  late GetGamesUseCase useCase;

  setUp(() {
    repository = MockGameRepositoryImpl();
    useCase = GetGamesUseCase(repository, DomainGameMapper());
  });

  test(
    'should get game for the number from the repository',
    () async {
      var testPlatform = 'Android';
      var domainGame = const DomainGame(
        id: 0,
        title: 'title',
        thumbnail: 'thumbnail',
        shortDescription: 'shortDescription',
        description: 'description',
        gameUrl: 'gameUrl',
        genre: 'genre',
        platform: 'platform',
        publisher: 'publisher',
        developer: 'developer',
        releaseDate: 'releaseDate',
        minimumSystemRequirements: {
          'os': "Windows 7 64-Bit (SP1) or Windows 10 64-Bit",
          'processor': "Intel Core i3-4340 or AMD FX-4300",
          'memory': "2GB RAM",
          'graphics': "Intel UHD Graphics 600",
          'storage': "HDD",
        },
        screenshots: [],
      );

      var game = const Game(
        id: 0,
        title: 'title',
        thumbnail: 'thumbnail',
        shortDescription: 'shortDescription',
        description: 'description',
        gameUrl: 'gameUrl',
        genre: 'genre',
        platform: 'platform',
        publisher: 'publisher',
        developer: 'developer',
        releaseDate: 'releaseDate',
        minimumSystemRequirements: SystemRequirements(
          os: "Windows 7 64-Bit (SP1) or Windows 10 64-Bit",
          processor: "Intel Core i3-4340 or AMD FX-4300",
          memory: "2GB RAM",
          graphics: "Intel UHD Graphics 600",
          storage: "HDD",
        ),
        screenshots: [],
      );

      // arrange
      when(repository.getGamesByPlatform(testPlatform))
          .thenAnswer((_) async => Right([domainGame]));
      // act
      final result = await useCase(Params(platform: testPlatform));
      // assert
      expect(result, Right<Failure, List<Game>>([game]));
      verify(repository.getGamesByPlatform(testPlatform));
      verifyNoMoreInteractions(repository);
    },
  );
}
