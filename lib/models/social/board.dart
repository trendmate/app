import 'dart:convert';

import 'package:flutter/foundation.dart';

class Board {
  final String boardId;
  final String title;
  final String image;
  final String description;
  final List<String> posts;
  final List<String> products;
  final List<String> tags;

  Board({
    required this.boardId,
    required this.title,
    required this.image,
    required this.description,
    required this.posts,
    required this.products,
    required this.tags,
  });

  Board copyWith({
    String? boardId,
    String? title,
    String? image,
    String? description,
    List<String>? posts,
    List<String>? products,
    List<String>? tags,
  }) {
    return Board(
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      posts: posts ?? this.posts,
      products: products ?? this.products,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boardId': boardId,
      'title': title,
      'image': image,
      'description': description,
      'posts': posts,
      'products': products,
      'tags': tags,
    };
  }

  factory Board.fromMap(Map<String, dynamic> map) {
    return Board(
      boardId: map['boardId'],
      title: map['title'],
      image: map['image'],
      description: map['description'],
      posts: List<String>.from(map['posts']),
      products: List<String>.from(map['products']),
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Board.fromJson(String source) => Board.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Board(boardId: $boardId, title: $title, image: $image, description: $description, posts: $posts, products: $products, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Board &&
        other.boardId == boardId &&
        other.title == title &&
        other.image == image &&
        other.description == description &&
        listEquals(other.posts, posts) &&
        listEquals(other.products, products) &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return boardId.hashCode ^
        title.hashCode ^
        image.hashCode ^
        description.hashCode ^
        posts.hashCode ^
        products.hashCode ^
        tags.hashCode;
  }
}
