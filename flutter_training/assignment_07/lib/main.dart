import 'package:assignment_07/data/album_mapper.dart';
import 'package:assignment_07/data/album_repository_impl.dart';
import 'package:assignment_07/domain/album_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'domain/album.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ApiScrollDemoPage(),
    );
  }
}

class ApiScrollDemoPage extends StatefulWidget {
  const ApiScrollDemoPage({Key? key}) : super(key: key);

  @override
  State<ApiScrollDemoPage> createState() => _ApiScrollDemoPageState();
}

class _ApiScrollDemoPageState extends State<ApiScrollDemoPage> {
  static const pageSize = 20;
  late Future<List<Album>> albums;
  final AlbumRepository _albumRepository = AlbumRepositoryImpl(AlbumMapper());
  final PagingController<int, Album> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    albums = _albumRepository.getAllAlbums();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _albumRepository.getAlbums(pageKey, pageSize);
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
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: PagedListView<int, Album>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Album>(
            itemBuilder: (context, item, index) => GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Selecionou: $item"),
                    ),
                  );
                },
                child: buildListItem(item)),
          ),
        ),
      ),
    );
  }

  ListView buildList(List<Album>? albums) {
    if (albums == null) return ListView();
    return ListView(
      children: albums.map((e) => buildListItem(e)).toList(),
    );
  }

  ListTile buildListItem(Album album) {
    return ListTile(
      title: Text(album.title),
      subtitle: Text("ID: ${album.id}"),
      trailing: Text("UID: ${album.userId}"),
    );
  }
}
