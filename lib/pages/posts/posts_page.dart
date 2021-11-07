import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/pages/posts/post_detail.dart';
import 'package:trendmate/providers/posts_provider.dart';

class PostsPage extends StatelessWidget {
  static const routeName = '/posts-page';
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostsProvider>(context, listen: false);
    // postsProvider.dummyInit();

    if (postsProvider.posts.isEmpty) {
      return Center(
        child: Text("No posts to show!"),
      );
    } else {
      return ListView.builder(
        itemCount: postsProvider.posts.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(PostDetail.routeName, arguments: index);
          },
          child: Card(
            child: ListTile(
              leading: postsProvider.posts[index].medias.length == 0
                  ? Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi2LRDx2P0EH77b_Mh_aAfKZ7inOY5CQAfiA&usqp=CAU")
                  : Image.network(postsProvider.posts[index].medias[0].url),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      postsProvider.posts[index].title,
                      maxLines: 2,
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.people),
                  Text(postsProvider.posts[index].share_no.toString()),
                ],
              ),
              subtitle: Text(
                postsProvider.posts[index].description,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(postsProvider.posts[index].by),
            ),
          ),
        ),
      );
    }
  }
}
