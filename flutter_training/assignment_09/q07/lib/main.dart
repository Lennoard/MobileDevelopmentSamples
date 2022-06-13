import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'data/emoji_mapper.dart';
import 'data/emoji_repository_impl.dart';
import 'domain/emoji.dart';
import 'domain/emoji_repository.dart';
import 'domain/get_response_use_case.dart';

void main() {
  runApp(const EmojiDex());
}

class EmojiDex extends StatelessWidget {
  const EmojiDex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emojis',
      theme: ThemeData(primarySwatch: Colors.cyan),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const pageSize = 20;
  String dropdownValue = 'Todos';
  Set<int> favoriteIds = {};

  late Future<List<Emoji>> emojis;
  final EmojiRepository _postsRepository = EmojiRepositoryImpl(EmojiMapper(), GetResponseUseCase());
  final PagingController<int, Emoji> _pagingController = PagingController(firstPageKey: 0);
  late Future<List<Emoji>> _future;

  Map<int, String> categories = {};

  @override
  void initState() {
    categories[0] = 'Todos';
    categories[1] = 'Smileys & People';
    categories[2] = 'Animals & Nature';
    categories[3] = 'Food & Drink';
    categories[4] = 'Travel & Places';
    categories[5] = 'Activities';

    _future = _postsRepository.getRandomEmojis();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    emojis = _postsRepository.getRandomEmojis();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _postsRepository.getEmojis(pageKey);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoji categories'),
        backgroundColor: Colors.cyan.shade700,
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Expanded(child: Text('Categoria: ')),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    var id = categories.values.toList().indexOf(dropdownValue);
                    _future = _postsRepository.getByCategory(id);
                  });
                },
                items: categories.values
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Emoji>>(
              future: _future,
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

  ListView buildList(List<Emoji>? emojis) {
    if (emojis == null) return ListView();
    return ListView(
      children: emojis.map((e) => buildListItem(e)).toList(),
    );
  }

  ListTile buildListItem(Emoji emoji) {
    var color =
    favoriteIds.contains(emoji.id) ? Colors.yellow.shade800 : Colors.grey.shade400;

    return ListTile(
      title: Text(emoji.toString()),
      subtitle: Text(emoji.name),
      trailing: Icon(
        favoriteIds.contains(emoji.id) ? Icons.favorite : Icons.favorite_border,
        color: color,
      ),
    );
  }
}
