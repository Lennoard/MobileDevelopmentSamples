import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean/core/error/failures.dart';
import 'package:tdd_clean/core/platform/network_info_impl.dart';
import 'package:tdd_clean/features/free_games/data/datasources/game_local_data_source_impl.dart';
import 'package:tdd_clean/features/free_games/data/datasources/game_remote_data_source_impl.dart';
import 'package:tdd_clean/features/free_games/data/mappers/domain_game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/mappers/game_mapper.dart';
import 'package:tdd_clean/features/free_games/data/models/game.dart';
import 'package:tdd_clean/features/free_games/data/repositories/game_repository_impl.dart';
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';
import 'package:tdd_clean/features/free_games/domain/repositories/game_repository.dart';
import 'package:tdd_clean/features/free_games/domain/usecases/get_games_use_case.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<DomainGame>> games;
  late GetGamesUseCase _getGamesUseCase;
  late GameRepository _gameRepository;

  @override
  void initState() {
    initRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Free games'),
        backgroundColor: Colors.cyan.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<dartz.Either<Failure, List<Game>>>(
              future: initRepo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }

  Future<dartz.Either<Failure, List<Game>>> initRepo() async {
    var mapper = GameMapper();
    var domainMapper = DomainGameMapper();
    _gameRepository = GameRepositoryImpl(
        GameRemoteDataSourceImpl(mapper, domainMapper),
        GameLocalDataSourceImpl(
          await SharedPreferences.getInstance(),
          mapper,
          domainMapper,
        ),
        NetworkInfoImpl(InternetConnectionChecker.createInstance()),
        domainMapper);
    _getGamesUseCase = GetGamesUseCase(_gameRepository, domainMapper);
    return _getGamesUseCase(const Params(platform: 'windows'));
  }

  ListView buildList(dartz.Either<Failure, List<Game>>? maybeGames) {
    if (maybeGames == null) return ListView();

    var games = maybeGames.getOrElse(() => []);
    return ListView(children: games.map((e) => buildListItem(e)).toList());
  }

  ListTile buildListItem(Game game) {
    return ListTile(
      title: Text(game.title),
      leading: Text(game.developer),
      subtitle: Text(game.developer),
      trailing: Text(game.genre),
    );
  }
}
