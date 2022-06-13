import 'package:assignment_07/domain/album.dart';

abstract class AlbumRepository {
   Future<List<Album>> getAllAlbums();
   Future<List<Album>> getAlbums(int start, int limit);
}
