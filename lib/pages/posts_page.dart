import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  static const routeName = '/posts-page';
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Posts Page"),
    );
  }
}
