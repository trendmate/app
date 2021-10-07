import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Favourite {
  Timestamp timeStamp;
  String id;

  Favourite({
    required this.timeStamp,
    required this.id,
  });

  Favourite copyWith({
    Timestamp? timeStamp,
    String? id,
  }) {
    return Favourite(
      timeStamp: timeStamp ?? this.timeStamp,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp,
      'id': id,
    };
  }

  factory Favourite.fromMap(Map<String, dynamic> map) {
    return Favourite(
      timeStamp: map['timeStamp'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Favourite.fromJson(String source) =>
      Favourite.fromMap(json.decode(source));

  @override
  String toString() => 'Favourite(timeStamp: $timeStamp, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Favourite && other.timeStamp == timeStamp && other.id == id;
  }

  @override
  int get hashCode => timeStamp.hashCode ^ id.hashCode;
}
