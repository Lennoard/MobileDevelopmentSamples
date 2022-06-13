import 'package:assignment_07/data/album_mapper.dart';
import 'package:assignment_07/data/album_repository_impl.dart';
import 'package:assignment_07/domain/album_repository.dart';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AlbumRepository _albumRepository = AlbumRepositoryImpl(AlbumMapper());
  late Future<List<Album>> albums;

  @override
  void initState() {
    super.initState();
    albums = _albumRepository.getAllAlbums();
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: FutureBuilder<List<Album>>(
              future: albums,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
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
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Selecionou: $album"),
          ),
        );
      },
    );
  }
}
