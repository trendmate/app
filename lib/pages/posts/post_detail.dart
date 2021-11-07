import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/models/media.dart';
import 'package:trendmate/providers/posts_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key}) : super(key: key);
  static const routeName = "/post-detail";

  @override
  Widget build(BuildContext context) {
    // postIndex will get us the post we want to display
    final postIndex = ModalRoute.of(context)!.settings.arguments as int;

    // loadedPost is the posts we want to display
    final loadedPost = Provider.of<PostsProvider>(context, listen: false)
        .findByIndex(postIndex);

    // convert and format timeStamp to datetime
    var dateTime = DateFormat("dd-MMMM, yyyy - h:mma").format(
        DateTime.fromMillisecondsSinceEpoch(
            loadedPost.dateTime.seconds * 1000));

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
                // google maps will open the location when clicked on locaton icon button
                launch(
                    "http://maps.google.com/maps?z=12&t=m&q=loc:${loadedPost.location?.latitude}+${loadedPost.location?.longitude}");
              },
              icon: Icon(Icons.location_on))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Slider for images and videos
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: loadedPost.medias.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    if (i.type == MediaType.image) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        // child: Image.network(i.url),
                        child: CachedNetworkImage(
                          imageUrl: i.url,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Text(""),
                        ),
                      );
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: GestureDetector(
                          onTap: () => launch(i.url),
                          child: Icon(Icons.play_arrow),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
            // show no. of shares
            Row(
              children: [
                Icon(Icons.people),
                Text(loadedPost.share_no.toString()),
              ],
            ),
            // author and datetime
            Text(
              "By: ${loadedPost.by} (${dateTime})",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            // description
            Text(loadedPost.description),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Tags: ",
              // "Tags: " + loadedPost.tags.length.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: loadedPost.tags.length,
                  itemBuilder: (ctx, i) => Card(
                        color: Colors.blue,
                        child: Text(loadedPost.tags[i],
                            style: TextStyle(color: Colors.white)))),
            ),
            Text(
              "Products: ",
              // "Products: " + loadedPost.products.length.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: loadedPost.products.length,
                itemBuilder: (ct, idx) => Text(loadedPost.products[idx]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
