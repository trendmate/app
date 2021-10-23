import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/models/media.dart';
import 'package:trendmate/providers/posts_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key}) : super(key: key);
  static const routeName = "/post-detail";

  @override
  Widget build(BuildContext context) {
    final postIndex = ModalRoute.of(context)!.settings.arguments as int;

    final loadedPost = Provider.of<PostsProvider>(context, listen: false)
        .findByIndex(postIndex);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          loadedPost.title,
          style: TextStyle(color: Colors.black, fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // launch(loadedPost.location),
              },
              icon: Icon(Icons.location_on))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.people),
                Text(loadedPost.share_no.toString()),
              ],
            ),
            // Row(children: [
            //   Text("Tags: "),
            //   ListView.builder(scrollDirection: Axis.horizontal, shrinkWrap: true, itemCount: loadedPost.tags.length, itemBuilder: (ctx, i) => Text(loadedPost.tags[i])),
            // ],),
            Text(
              "By: ${loadedPost.by}",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            Text(loadedPost.description),
            SizedBox(
              height: 5,
            ),
            // GridView.builder(
            //   shrinkWrap: true,
            //     itemCount: loadedPost.medias.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       childAspectRatio: 3 / 2,
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 10,
            //     ),
            //     itemBuilder: (ctx, i) {
            //       if (loadedPost.medias[i].type == MediaType.image) {
            //         return Image.network(loadedPost.medias[i].url);
            //       } else {
            //         return Text("url: ${loadedPost.medias[i].url}");
            //       }
            //     }),
            SizedBox(
              height: 10,
            ),
            Text(
              "Products",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            // ListView.builder(
            //   itemCount: loadedPost.products.length,
            //   itemBuilder: (ct, idx) => Text(loadedPost.products[idx]),
            // ),
          ],
        ),
      ),
    );
  }
}
