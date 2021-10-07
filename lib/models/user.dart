import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  final String uid;
  final String name;
  final String phone;
  final String image;
  final String cover;
  final String bio;
  final Timestamp joined;
  final GeoPoint location;
  final List<String> my_boards;
  final List<String> followed_boards;
  final List<String> friends;

  User({
    required this.uid,
    required this.name,
    required this.phone,
    required this.image,
    required this.cover,
    required this.bio,
    required this.joined,
    required this.location,
    required this.my_boards,
    required this.followed_boards,
    required this.friends,
  });

  User copyWith({
    String? uid,
    String? name,
    String? phone,
    String? image,
    String? cover,
    String? bio,
    Timestamp? joined,
    GeoPoint? location,
    List<String>? my_boards,
    List<String>? followed_boards,
    List<String>? friends,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      cover: cover ?? this.cover,
      bio: bio ?? this.bio,
      joined: joined ?? this.joined,
      location: location ?? this.location,
      my_boards: my_boards ?? this.my_boards,
      followed_boards: followed_boards ?? this.followed_boards,
      friends: friends ?? this.friends,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'image': image,
      'cover': cover,
      'bio': bio,
      'joined': joined,
      'location': location,
      'my_boards': my_boards,
      'followed_boards': followed_boards,
      'friends': friends,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
      image: map['image'],
      cover: map['cover'],
      bio: map['bio'],
      joined: map['joined'],
      location: map['location'],
      my_boards: List<String>.from(map['my_boards']),
      followed_boards: List<String>.from(map['followed_boards']),
      friends: List<String>.from(map['friends']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, phone: $phone, image: $image, cover: $cover, bio: $bio, joined: $joined, location: $location, favourite_products: $my_boards, followed_boards: $followed_boards, friends: $friends)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.name == name &&
        other.phone == phone &&
        other.image == image &&
        other.cover == cover &&
        other.bio == bio &&
        other.joined == joined &&
        other.location == location &&
        listEquals(other.my_boards, my_boards) &&
        listEquals(other.followed_boards, followed_boards) &&
        listEquals(other.friends, friends);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        cover.hashCode ^
        bio.hashCode ^
        joined.hashCode ^
        location.hashCode ^
        my_boards.hashCode ^
        followed_boards.hashCode ^
        friends.hashCode;
  }
}
