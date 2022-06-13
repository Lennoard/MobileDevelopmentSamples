import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean/core/error/failures.dart';
import 'package:tdd_clean/features/free_games/data/mappers/domain_game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/mappers/game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/repositories/game_repository_impl.dart';
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';

import 'get_games_repository_test.mocks.dart';

@GenerateMocks([GameRepositoryImpl, GameMapper, DomainGameMapper])
void main() {
  test('given (invalid game ID) when (executed) then (should return GameNotFoundFailure)', () async {
    // Given
    var mapper = MockGameMapper();
    var repository = GameRepositoryImpl(mapper);
    int badGameId = -1;

    // When
    var response = await repository.getGame(badGameId);

    // Then
    response.fold(
        (l) => {expect(l, GameNotFoundFailure())}, (r) => {expect(r, null)});
  });

  test('given (valid game ID) when (executed) then (should return Game)', () async {
    // Given
    var mapper = MockGameMapper();
    var repository = GameRepositoryImpl(mapper);
    int gameId = 31;
    DomainGame game = stubGame(gameId);
    when(mapper.map(any)).thenReturn(game);

    // When
    var response = await repository.getGame(gameId);

    // Then
    response.fold((l) => {
      expect(l, null)
    }, (r) => {
      expect(r.id, gameId)
    });
  });
}

DomainGame stubGame(int gameId) {
  return DomainGame(
    id: gameId,
    title: 'title',
    thumbnail: 'thumbnail',
    shortDescription: 'shortDescription',
    description: 'description',
    gameUrl: 'gameUrl',
    genre: 'genre',
    platform: 'platform',
    publisher: 'publisher',
    developer: 'developer',
    releaseDate: '2020-05-05',
    minimumSystemRequirements: const {},
    screenshots: const [],
  );
}
