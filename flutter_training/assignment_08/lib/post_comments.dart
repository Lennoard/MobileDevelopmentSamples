import 'package:assignment_07/data/post_mapper.dart';
import 'package:assignment_07/data/post_repository_impl.dart';
import 'package:assignment_07/domain/post_repository.dart';
import 'package:flutter/material.dart';

import 'domain/comment.dart';
import 'domain/post.dart';

class PostCommentsPage extends StatefulWidget {
  const PostCommentsPage({Key? key}) : super(key: key);

  static const String routeName = '/comments';

  @override
  State<PostCommentsPage> createState() => _PostCommentsPageState();
}

class _PostCommentsPageState extends State<PostCommentsPage> {
  final PostRepository _postsRepository = PostRepositoryImpl(PostMapper());

  @override
  Widget build(BuildContext context) {
    Post post = ModalRoute.of(context)?.settings.arguments as Post;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: Colors.pink.shade900,
      ),
      body: FutureBuilder(
          future: _postsRepository.getComments(post.id),
          builder:(context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Comment> comments = snapshot.data;
              return Container(
                  child: ListView.separated(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return buildListItem(comments[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                  )
              );
            }
          }
      ),
    );
  }

  ListTile buildListItem(Comment comment) {
    return ListTile(
      title: Text(comment.name),
      subtitle: Text(comment.body.substring(0, 64)),
    );
  }
}
