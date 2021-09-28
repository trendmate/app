import 'dart:convert';

class Store {
  final String storeId;
  final String name;
  final String image;
  final String instaId;
  final String site;
  
  Store({
    required this.storeId,
    required this.name,
    required this.image,
    required this.instaId,
    required this.site,
  });

  Store copyWith({
    String? storeId,
    String? name,
    String? image,
    String? instaId,
    String? site,
  }) {
    return Store(
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      image: image ?? this.image,
      instaId: instaId ?? this.instaId,
      site: site ?? this.site,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'name': name,
      'image': image,
      'instaId': instaId,
      'site': site,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      storeId: map['storeId'],
      name: map['name'],
      image: map['image'],
      instaId: map['instaId'],
      site: map['site'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) => Store.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Store(storeId: $storeId, name: $name, image: $image, instaId: $instaId, site: $site)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Store &&
      other.storeId == storeId &&
      other.name == name &&
      other.image == image &&
      other.instaId == instaId &&
      other.site == site;
  }

  @override
  int get hashCode {
    return storeId.hashCode ^
      name.hashCode ^
      image.hashCode ^
      instaId.hashCode ^
      site.hashCode;
  }
}
