import 'dart:convert';

class Filter {
  double priceStart;
  double priceEnd;
  Map<String, bool> cats;
  Map<String, bool> sites;
  Map<String, bool> brands;
  Map<String, bool> gender;

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
      cats: Map<String, bool>.from(map['cats']),
      sites: Map<String, bool>.from(map['sites']),
      brands: Map<String, bool>.from(map['brands']),
      gender: Map<String, bool>.from(map['gender']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Filter.fromJson(String source) => Filter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Filter(priceStart: $priceStart, priceEnd: $priceEnd, cats: $cats, sites: $sites, brands: $brands, gender: $gender)';
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
