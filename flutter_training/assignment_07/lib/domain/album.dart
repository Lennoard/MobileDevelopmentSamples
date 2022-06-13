class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  @override
  String toString() {
    return 'Album{title: $title}';
  }
}
