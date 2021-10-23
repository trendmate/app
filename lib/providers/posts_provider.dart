import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:trendmate/models/media.dart';
import 'package:trendmate/models/social/post.dart';

class PostsProvider with ChangeNotifier {
  List<Post> _posts = [];

  void dummyInit() {
    _posts.add(Post(
      postId: '1',
      title: 'post1',
      by: 'Author1',
      dateTime: Timestamp.fromDate(DateTime.now()),
      medias: [
        Media(
            mediaId: '1',
            type: MediaType.image,
            url:
                "https://cdn.pixabay.com/photo/2016/05/20/17/17/social-media-1405601_1280.png",
            title: "media-1")
      ],
      location: GeoPoint(4.5, 4.5),
      share_no: 5,
      tags: ['t-shirt', 'red'],
      description: 'Hello, world!',
      products: ['product-1', 'product-2'],
    ));
  }

  List<Post> get posts {
    return [..._posts];
  }

  Post findByIndex(int i) {
    return _posts[i];
  }
}
