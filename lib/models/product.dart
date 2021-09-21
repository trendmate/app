import 'dart:convert';

class Product {
  final String brand;
  final String category;
  final String desc;
  final String imageUrl;
  final String name;
  final int price;
  final double rating;
  final int reviews;
  final double trendiness;
  final String productUrl;

  Product({
    required this.brand,
    required this.category,
    required this.desc,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.trendiness,
    required this.productUrl,
  });

  Product copyWith({
    String? brand,
    String? category,
    String? desc,
    String? imageUrl,
    String? name,
    int? price,
    double? rating,
    int? reviews,
    double? trendiness,
    String? productUrl,
  }) {
    return Product(
      brand: brand ?? this.brand,
      category: category ?? this.category,
      desc: desc ?? this.desc,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      trendiness: trendiness ?? this.trendiness,
      productUrl: productUrl ?? this.productUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'category': category,
      'desc': desc,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'rating': rating,
      'reviews': reviews,
      'trendiness': trendiness,
      'productUrl': productUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      brand: map['brand'],
      category: map['category'],
      desc: map['desc'],
      imageUrl: map['imageUrl'],
      name: map['name'],
      price: map['price'],
      rating: map['rating'],
      reviews: map['reviews'],
      trendiness: map['trendiness'],
      productUrl: map['productUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(brand: $brand, category: $category, desc: $desc, imageUrl: $imageUrl, name: $name, price: $price, rating: $rating, reviews: $reviews, trendiness: $trendiness, productUrl: $productUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.brand == brand &&
        other.category == category &&
        other.desc == desc &&
        other.imageUrl == imageUrl &&
        other.name == name &&
        other.price == price &&
        other.rating == rating &&
        other.reviews == reviews &&
        other.trendiness == trendiness &&
        other.productUrl == productUrl;
  }

  @override
  int get hashCode {
    return brand.hashCode ^
        category.hashCode ^
        desc.hashCode ^
        imageUrl.hashCode ^
        name.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        reviews.hashCode ^
        trendiness.hashCode ^
        productUrl.hashCode;
  }
}
