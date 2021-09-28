import 'dart:convert';

class Category {
  final String categoryId;
  final String name;
  final String image;

  Category({
    required this.categoryId,
    required this.name,
    required this.image,
  });

  Category copyWith({
    String? categoryId,
    String? name,
    String? image,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'image': image,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'],
      name: map['name'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() =>
      'Category(categoryId: $categoryId, name: $name, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.categoryId == categoryId &&
        other.name == name &&
        other.image == image;
  }

  @override
  int get hashCode => categoryId.hashCode ^ name.hashCode ^ image.hashCode;
}
