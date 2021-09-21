import 'dart:convert';

import 'package:flutter/foundation.dart';

class Filter {
  double priceStart;
  double priceEnd;
  List<String> cats;
  List<String> sites;
  List<String> brands;
  List<String> gender;

  Filter({
    required this.priceStart,
    required this.priceEnd,
    required this.cats,
    required this.sites,
    required this.brands,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'priceStart': priceStart,
      'priceEnd': priceEnd,
      'cats': cats,
      'sites': sites,
      'brands': brands,
      'gender': gender,
    };
  }

  factory Filter.fromMap(Map<String, dynamic> map) {
    return Filter(
      priceStart: map['priceStart'],
      priceEnd: map['priceEnd'],
      cats: List<String>.from(map['cats']),
      sites: List<String>.from(map['sites']),
      brands: List<String>.from(map['brands']),
      gender: List<String>.from(map['gender']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Filter.fromJson(String source) => Filter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Filter(priceStart: $priceStart, priceEnd: $priceEnd, cats: $cats, sites: $sites, brands: $brands, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Filter &&
        other.priceStart == priceStart &&
        other.priceEnd == priceEnd &&
        listEquals(other.cats, cats) &&
        listEquals(other.sites, sites) &&
        listEquals(other.brands, brands) &&
        listEquals(other.gender, gender);
  }

  @override
  int get hashCode {
    return priceStart.hashCode ^
        priceEnd.hashCode ^
        cats.hashCode ^
        sites.hashCode ^
        brands.hashCode ^
        gender.hashCode;
  }
}
