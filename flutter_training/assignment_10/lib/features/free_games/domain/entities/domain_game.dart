import 'package:equatable/equatable.dart';

class DomainGame extends Equatable {
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
  final Map<String, dynamic> minimumSystemRequirements;
  final List<Map<String, dynamic>> screenshots;

  const DomainGame({
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