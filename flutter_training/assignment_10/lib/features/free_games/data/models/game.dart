import 'package:equatable/equatable.dart';
import 'package:tdd_clean/features/free_games/data/models/screenshot.dart';
import 'package:tdd_clean/features/free_games/data/models/system_requirement.dart';

class Game extends Equatable {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String description;
  final String gameUrl;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;
  final SystemRequirements minimumSystemRequirements;
  final List<Screenshot> screenshots;

  const Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.description,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.minimumSystemRequirements,
    required this.screenshots
  });

  @override
  List<Object?> get props => [id];
}
