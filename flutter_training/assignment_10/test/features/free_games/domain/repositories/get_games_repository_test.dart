import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean/core/error/exception.dart';
import 'package:tdd_clean/core/error/failures.dart';
import 'package:tdd_clean/core/platform/network_info.dart';
import 'package:tdd_clean/features/free_games/data/mappers/domain_game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/models/game.dart';
import 'package:tdd_clean/features/free_games/data/models/system_requirement.dart';
import 'package:tdd_clean/features/free_games/data/repositories/game_repository_impl.dart';
import 'package:tdd_clean/features/free_games/domain/datasources/game_local_data_source.dart';
import 'package:tdd_clean/features/free_games/domain/datasources/game_remote_data_source.dart';
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';

import 'get_games_repository_test.mocks.dart';

@GenerateMocks([
  GameRepositoryImpl,
  DomainGameMapper,
  GameLocalDataSource,
  GameRemoteDataSource,
  NetworkInfo,
])
void main() {
  var mapper = MockDomainGameMapper();
  var remoteSource = MockGameRemoteDataSource();
  var localSource = MockGameLocalDataSource();
  var networkInfo = MockNetworkInfo();

  test(
      'given (invalid game ID) when (executed) then (should return GameNotFoundFailure)',
      () async {
    // Given
    var repository =
        GameRepositoryImpl(remoteSource, localSource, networkInfo, mapper);
    int badGameId = -1;
    when(networkInfo.isConnected).thenAnswer((_) => Future(() => true));
    when(remoteSource.getGame(badGameId)).thenThrow(GameNotFoundException());

    // When
    var response = await repository.getGame(badGameId);

    // Then
    response.fold(
        (l) => {expect(l, GameNotFoundFailure())}, (r) => {expect(r, null)});
  });

  test('given (valid game ID) when (executed) then (should return Game)',
      () async {
    // Given
    var repository =
        GameRepositoryImpl(remoteSource, localSource, networkInfo, mapper);
    int gameId = 31;
    Game game = stubGame(gameId);
    DomainGame domainGame = stubDomainGame(gameId);
    when(networkInfo.isConnected).thenAnswer((_) => Future(() => true));
    when(remoteSource.getGame(gameId)).thenAnswer((_) => Future(() => game));
    when(mapper.unmap(game)).thenReturn(domainGame);

    // When
    var response = await repository.getGame(gameId);

    // Then
    response.fold((l) => {expect(l, null)}, (r) => {expect(r.id, gameId)});
  });
}

DomainGame stubDomainGame(int gameId) {
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

Game stubGame(int gameId) {
  return Game(
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
    minimumSystemRequirements: const SystemRequirements(
        os: 'os',
        processor: 'processor',
        memory: 'memory',
        graphics: 'graphics',
        storage: 'storage'),
    screenshots: const [],
  );
}
