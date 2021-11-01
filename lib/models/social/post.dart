import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:trendmate/models/media.dart';

class Post {
  final String postId;
  final String title;
  final String by;
  final Timestamp dateTime;
  final List<Media> medias;
  final GeoPoint? location;
  final int share_no;
  final List<String> tags;
  final String description;
  final List<String> products;
  final double trendiness;

  Post({
    required this.postId,
    required this.title,
    required this.by,
    required this.dateTime,
    required this.medias,
    this.location,
    required this.share_no,
    required this.tags,
    required this.description,
    required this.products,
    required this.trendiness,
  });

  Post copyWith({
    String? postId,
    String? title,
    String? by,
    Timestamp? dateTime,
    List<Media>? medias,
    GeoPoint? location,
    int? share_no,
    List<String>? tags,
    String? description,
    List<String>? products,
    double? trendiness,
  }) {
    return Post(
        postId: postId ?? this.postId,
        title: title ?? this.title,
        by: by ?? this.by,
        dateTime: dateTime ?? this.dateTime,
        medias: medias ?? this.medias,
        location: location ?? this.location,
        share_no: share_no ?? this.share_no,
        tags: tags ?? this.tags,
        description: description ?? this.description,
        products: products ?? this.products,
        trendiness: trendiness ?? this.trendiness);
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'title': title,
      'by': by,
      'dateTime': dateTime,
      'medias': medias.map((x) => x.toMap()).toList(),
      'location': location,
      'share_no': share_no,
      'tags': tags,
      'description': description,
      'products': products,
      'trendiness': trendiness,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'],
      title: map['title'],
      by: map['by'],
      dateTime: map['dateTime'],
      medias: List<Media>.from(map['medias'].map((x) => Media.fromMap(x))),
      location: map['location'],
      share_no: map['share_no'],
      tags: List<String>.from(map['tags']),
      description: map['description'],
      products: List<String>.from(map['products']),
      trendiness: map['trendiness'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postId: $postId, title: $title, by: $by, dateTime: $dateTime, medias: $medias, location: $location, share_no: $share_no, tags: $tags, description: $description, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.postId == postId &&
        other.title == title &&
        other.by == by &&
        other.dateTime == dateTime &&
        listEquals(other.medias, medias) &&
        other.location == location &&
        other.share_no == share_no &&
        listEquals(other.tags, tags) &&
        other.description == description &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        title.hashCode ^
        by.hashCode ^
        dateTime.hashCode ^
        medias.hashCode ^
        location.hashCode ^
        share_no.hashCode ^
        tags.hashCode ^
        description.hashCode ^
        products.hashCode;
  }
}
