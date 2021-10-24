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
            title: "media-1"),
        Media(
            mediaId: '2',
            type: MediaType.image,
            url: "https://bit.ly/3GiLVar",
            title: "media-2"),
        Media(
            mediaId: '3',
            type: MediaType.video,
            url: "https://www.youtube.com/watch?v=WgU7P6o-GkM",
            title: "media-3"),
      ],
      location: GeoPoint(4.5, 4.5),
      share_no: 5,
      tags: ['tag-1', 'tag-2', 'tag-3333'],
      description:
          "Fiction-writing also has modes: action, exposition, description, dialogue, summary, and transition.[4] Author Peter Selgin refers to methods, including action, dialogue, thoughts, summary, scenes, and description.[5] Currently, there is no consensus within the writing community regarding the number and composition of fiction-writing modes and their uses. Description is the fiction-writing mode for transmitting a mental image of the particulars of a story. Together with dialogue, narration, exposition, and summarization, description is one of the most widely recognized of the fiction-writing modes. As stated in Writing from A to Z, edited by Kirk Polking, description is more than the amassing of details; it is bringing something to life by carefully choosing and arranging words and phrases to produce the desired effect.[6] The most appropriate and effective techniques for presenting description are a matter of ongoing discussion among writers and writing coaches.",
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
