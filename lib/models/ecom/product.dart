import 'dart:convert';

class Product {
  final String productId;
  final String brand;
  final String category;
  final String description;
  final String image;
  final String title;
  final double price; // price*100
  final double rating; // out of 500 (5.00)
  final String reviews_no;
  final int share_no;
  final double trendiness;
  final String url;
  final String demographic;
  final String store;
  final String occasion;
  
  Product({
    required this.productId,
    required this.brand,
    required this.category,
    required this.description,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.reviews_no,
    required this.share_no,
    required this.trendiness,
    required this.url,
    required this.demographic,
    required this.store,
    required this.occasion,
  });

  Product copyWith({
    String? productId,
    String? brand,
    String? category,
    String? description,
    String? image,
    String? title,
    double? price,
    double? rating,
    String? reviews_no,
    int? share_no,
    double? trendiness,
    String? url,
    String? demographic,
    String? store,
    String? occasion,
  }) {
    return Product(
      productId: productId ?? this.productId,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviews_no: reviews_no ?? this.reviews_no,
      share_no: share_no ?? this.share_no,
      trendiness: trendiness ?? this.trendiness,
      url: url ?? this.url,
      demographic: demographic ?? this.demographic,
      store: store ?? this.store,
      occasion: occasion ?? this.occasion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'brand': brand,
      'category': category,
      'description': description,
      'image': image,
      'title': title,
      'price': price,
      'rating': rating,
      'reviews_no': reviews_no,
      'share_no': share_no,
      'trendiness': trendiness,
      'url': url,
      'demographic': demographic,
      'store': store,
      'occasion': occasion,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'],
      brand: map['brand'],
      category: map['category'],
      description: map['description'],
      image: map['image'],
      title: map['title'],
      price: map['price'],
      rating: map['rating'],
      reviews_no: map['reviews_no'],
      share_no: map['share_no'],
      trendiness: map['trendiness'],
      url: map['url'],
      demographic: map['demographic'],
      store: map['store'],
      occasion: map['occasion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(productId: $productId, brand: $brand, category: $category, description: $description, image: $image, title: $title, price: $price, rating: $rating, reviews_no: $reviews_no, share_no: $share_no, trendiness: $trendiness, url: $url, demographic: $demographic, store: $store, occasion: $occasion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.productId == productId &&
      other.brand == brand &&
      other.category == category &&
      other.description == description &&
      other.image == image &&
      other.title == title &&
      other.price == price &&
      other.rating == rating &&
      other.reviews_no == reviews_no &&
      other.share_no == share_no &&
      other.trendiness == trendiness &&
      other.url == url &&
      other.demographic == demographic &&
      other.store == store &&
      other.occasion == occasion;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      brand.hashCode ^
      category.hashCode ^
      description.hashCode ^
      image.hashCode ^
      title.hashCode ^
      price.hashCode ^
      rating.hashCode ^
      reviews_no.hashCode ^
      share_no.hashCode ^
      trendiness.hashCode ^
      url.hashCode ^
      demographic.hashCode ^
      store.hashCode ^
      occasion.hashCode;
  }
}
