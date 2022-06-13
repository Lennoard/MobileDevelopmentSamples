import 'package:tdd_clean/features/free_games/data/models/screenshot.dart';
import 'package:tdd_clean/features/free_games/data/models/system_requirement.dart';
import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';

import '../models/game.dart';

class DomainGameMapper {
  Game map(DomainGame domainGame) {
    return Game(
      id: domainGame.id,
      title: domainGame.title,
      thumbnail: domainGame.thumbnail,
      shortDescription: domainGame.shortDescription,
      description: domainGame.description,
      gameUrl: domainGame.gameUrl,
      genre: domainGame.genre,
      platform: domainGame.platform,
      publisher: domainGame.publisher,
      developer: domainGame.developer,
      releaseDate: domainGame.releaseDate,
      minimumSystemRequirements: SystemRequirements(
        os: domainGame.minimumSystemRequirements['os'],
        processor: domainGame.minimumSystemRequirements['processor'],
        memory: domainGame.minimumSystemRequirements['memory'],
        graphics: domainGame.minimumSystemRequirements['graphics'],
        storage: domainGame.minimumSystemRequirements['storage'],
      ),
      screenshots: domainGame.screenshots
          .map((e) => Screenshot(id: e['id'], image: e['image']))
          .toList(),
    );
  }
}
