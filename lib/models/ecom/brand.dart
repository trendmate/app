import 'dart:convert';

class Brand {
  final String brandId;
  final String name;
  final String image;
  final String instaId;
  final String site;

  Brand({
    required this.brandId,
    required this.name,
    required this.image,
    required this.instaId,
    required this.site,
  });

  Brand copyWith({
    String? brandId,
    String? name,
    String? image,
    String? instaId,
    String? site,
  }) {
    return Brand(
      brandId: brandId ?? this.brandId,
      name: name ?? this.name,
      image: image ?? this.image,
      instaId: instaId ?? this.instaId,
      site: site ?? this.site,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brandId': brandId,
      'name': name,
      'image': image,
      'instaId': instaId,
      'site': site,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      brandId: map['brandId'],
      name: map['name'],
      image: map['image'],
      instaId: map['instaId'],
      site: map['site'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Brand(brandId: $brandId, name: $name, image: $image, instaId: $instaId, site: $site)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Brand &&
        other.brandId == brandId &&
        other.name == name &&
        other.image == image &&
        other.instaId == instaId &&
        other.site == site;
  }

  @override
  int get hashCode {
    return brandId.hashCode ^
        name.hashCode ^
        image.hashCode ^
        instaId.hashCode ^
        site.hashCode;
  }
}
