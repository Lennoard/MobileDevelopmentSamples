// Mocks generated by Mockito 5.2.0 from annotations
// in tdd_clean/test/features/free_games/domain/usecases/get_games_use_case_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;

import 'package:dartz/dartz.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tdd_clean/core/error/failures.dart' as _i10;
import 'package:tdd_clean/core/platform/network_info.dart' as _i4;
import 'package:tdd_clean/features/free_games/data/mappers/domain_game_mapper.dart'
    as _i12;
import 'package:tdd_clean/features/free_games/data/mappers/game_mapper.dart'
    as _i11;
import 'package:tdd_clean/features/free_games/data/models/game.dart' as _i7;
import 'package:tdd_clean/features/free_games/data/repositories/game_repository_impl.dart'
    as _i8;
import 'package:tdd_clean/features/free_games/domain/datasources/game_local_data_source.dart'
    as _i3;
import 'package:tdd_clean/features/free_games/domain/datasources/game_remote_data_source.dart'
    as _i2;
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGameRemoteDataSource_0 extends _i1.Fake
    implements _i2.GameRemoteDataSource {}

class _FakeGameLocalDataSource_1 extends _i1.Fake
    implements _i3.GameLocalDataSource {}

class _FakeNetworkInfo_2 extends _i1.Fake implements _i4.NetworkInfo {}

class _FakeEither_3<L, R> extends _i1.Fake implements _i5.Either<L, R> {}

class _FakeDomainGame_4 extends _i1.Fake implements _i6.DomainGame {}

class _FakeGame_5 extends _i1.Fake implements _i7.Game {}

/// A class which mocks [GameRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockGameRepositoryImpl extends _i1.Mock
    implements _i8.GameRepositoryImpl {
  MockGameRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GameRemoteDataSource get remoteDataSource => (super.noSuchMethod(
      Invocation.getter(#remoteDataSource),
      returnValue: _FakeGameRemoteDataSource_0()) as _i2.GameRemoteDataSource);
  @override
  _i3.GameLocalDataSource get localDataSource => (super.noSuchMethod(
      Invocation.getter(#localDataSource),
      returnValue: _FakeGameLocalDataSource_1()) as _i3.GameLocalDataSource);
  @override
  _i4.NetworkInfo get networkInfo =>
      (super.noSuchMethod(Invocation.getter(#networkInfo),
          returnValue: _FakeNetworkInfo_2()) as _i4.NetworkInfo);
  @override
  _i9.Future<_i5.Either<_i10.Failure, _i6.DomainGame>> getGame(int? id) =>
      (super.noSuchMethod(Invocation.method(#getGame, [id]),
          returnValue: Future<_i5.Either<_i10.Failure, _i6.DomainGame>>.value(
              _FakeEither_3<_i10.Failure, _i6.DomainGame>())) as _i9
          .Future<_i5.Either<_i10.Failure, _i6.DomainGame>>);
  @override
  _i9.Future<_i5.Either<_i10.Failure, List<_i6.DomainGame>>> getGamesByPlatform(
          String? platform) =>
      (super.noSuchMethod(Invocation.method(#getGamesByPlatform, [platform]),
              returnValue:
                  Future<_i5.Either<_i10.Failure, List<_i6.DomainGame>>>.value(
                      _FakeEither_3<_i10.Failure, List<_i6.DomainGame>>()))
          as _i9.Future<_i5.Either<_i10.Failure, List<_i6.DomainGame>>>);
  @override
  _i9.Future<_i5.Either<_i10.Failure, List<_i6.DomainGame>>> getGamesList() =>
      (super.noSuchMethod(Invocation.method(#getGamesList, []),
              returnValue:
                  Future<_i5.Either<_i10.Failure, List<_i6.DomainGame>>>.value(
                      _FakeEither_3<_i10.Failure, List<_i6.DomainGame>>()))
          as _i9.Future<_i5.Either<_i10.Failure, List<_i6.DomainGame>>>);
}

/// A class which mocks [GameMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockGameMapper extends _i1.Mock implements _i11.GameMapper {
  MockGameMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.DomainGame map(Map<String, dynamic>? json) =>
      (super.noSuchMethod(Invocation.method(#map, [json]),
          returnValue: _FakeDomainGame_4()) as _i6.DomainGame);
}

/// A class which mocks [DomainGameMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDomainGameMapper extends _i1.Mock implements _i12.DomainGameMapper {
  MockDomainGameMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Game map(_i6.DomainGame? domainGame) =>
      (super.noSuchMethod(Invocation.method(#map, [domainGame]),
          returnValue: _FakeGame_5()) as _i7.Game);
  @override
  _i6.DomainGame unmap(_i7.Game? game) =>
      (super.noSuchMethod(Invocation.method(#unmap, [game]),
          returnValue: _FakeDomainGame_4()) as _i6.DomainGame);
}
