import 'package:assignment_07/data/post_mapper.dart';
import 'package:assignment_07/data/post_repository_impl.dart';
import 'package:assignment_07/domain/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'domain/post.dart';
import 'post_comments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts',
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: '/',
      routes: {
        '/': (context) => const PostsPage(),
        PostCommentsPage.routeName: (context) => const PostCommentsPage()
      },
    );
  }
}

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  static const pageSize = 20;
  late Future<List<Post>> posts;
  final PostRepository _postsRepository = PostRepositoryImpl(PostMapper());
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    posts = _postsRepository.getAllPosts();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _postsRepository.getPosts(pageKey, pageSize);
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
        title: const Text('Posts'),
        backgroundColor: Colors.pink.shade900,
      ),
      body: PagedListView<int, Post>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, item, index) => GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(PostCommentsPage.routeName, arguments: item);
              },
              child: buildListItem(item)),
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  ListView buildList(List<Post>? posts) {
    if (posts == null) return ListView();
    return ListView(
      children: posts.map((e) => buildListItem(e)).toList(),
    );
  }

  ListTile buildListItem(Post post) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.body.substring(0, 64)),
      trailing: Text("ID: ${post.id}"),
    );
  }
}
