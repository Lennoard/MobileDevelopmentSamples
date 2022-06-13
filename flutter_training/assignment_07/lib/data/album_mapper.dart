import '../domain/album.dart';

class AlbumMapper {
   Album map(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

   Map<String, dynamic> unmap(Album album) {
     return {
       'userId': album.userId,
       'id': album.id,
       'title': album.title
     };
   }
}
