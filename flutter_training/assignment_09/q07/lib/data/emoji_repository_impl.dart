import 'dart:convert';
import 'package:http/http.dart' as http;

import '../domain/emoji.dart';
import '../domain/emoji_repository.dart';
import '../domain/get_response_use_case.dart';
import 'emoji_mapper.dart';

class EmojiRepositoryImpl extends EmojiRepository {
  final EmojiMapper _mapper;
  final GetResponseUseCase _useCase;

  EmojiRepositoryImpl(this._mapper, this._useCase);

  @override
  Future<List<Emoji>> getEmojis(int limit) async {
    var response = await _useCase.execute('https://api.emojisworld.fr/v1/random?limit=$limit');
    return _mapEmoji(response);
  }

  @override
  Future<List<Emoji>> getRandomEmojis() {
    return getEmojis(50);
  }

  @override
  Future<List<Emoji>> search(String query, int? limit) async {
    var response = await _useCase.execute(
        'https://api.emojisworld.fr/v1/search?q=$query&limit=${limit ?? 50}'
    );
    return _mapEmoji(response);
  }

  @override
  Future<List<Emoji>> searchWithCategory(String query, int? limit, List<int>? categories, List<int>? subCategories) async {
    var response = await _useCase.execute(
        'https://api.emojisworld.fr/v1/search?q=$query&limit=${limit ?? 50}?categories=${categories ?? []}?sub_categories=${subCategories ?? []}'
    );
    return _mapEmoji(response);
  }

  @override
  Future<List<Emoji>> getByCategory(int category) async {
    if (category == 0) return getRandomEmojis();
    var response = await _useCase.execute(
        'https://api.emojisworld.fr/v1/random?categories=$category'
    );
    return _mapEmoji(response);
  }

  List<Emoji> _mapEmoji(http.Response response) {
    var map = jsonDecode(response.body) as Map;
    var results = map['results'] as List;
    return results.map((e) => _mapper.map(e)).toList();
  }
}
