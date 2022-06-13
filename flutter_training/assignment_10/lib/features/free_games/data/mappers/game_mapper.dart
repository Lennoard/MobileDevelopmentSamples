import 'package:tdd_clean/features/free_games/domain/entities/domain_game.dart';

class GameMapper {
  DomainGame map(Map<String, dynamic> json) {
    return DomainGame(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      shortDescription: json['shortDescription'],
      description: json['description'],
      gameUrl: json['gameUrl'],
      genre: json['genre'],
      platform: json['platform'],
      publisher: json['publisher'],
      developer: json['developer'],
      releaseDate: json['releaseDate'],
      minimumSystemRequirements: json['minimumSystemRequirements'],
      screenshots: json['screenshots'],
    );
  }
}
