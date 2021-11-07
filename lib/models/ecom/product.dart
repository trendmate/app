import 'dart:convert';

class Product {
  String productId;
  final String brand;
  final String category;
  final String description;
  final String image;
  final String title;
  final double price; // price*100
  final double rating; // out of 500 (5.00)
  final int reviews_no;
  int share_no;
  final int trendiness;
  final String url;
  final String demographic;
  final String store;
  final String occasion;
  final String? fromUid;
  final String? fromUserName;
  final String? fromBoardId;
  final String? fromBoardName;

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
    required this.fromUid,
    required this.fromUserName,
    required this.fromBoardId,
    required this.fromBoardName,
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
    int? reviews_no,
    int? share_no,
    int? trendiness,
    String? url,
    String? demographic,
    String? store,
    String? occasion,
    String? fromUid,
    String? fromUserName,
    String? fromBoardId,
    String? fromBoardName,
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
      fromUid: fromUid ?? this.fromUid,
      fromUserName: fromUserName ?? this.fromUserName,
      fromBoardId: fromBoardId ?? this.fromBoardId,
      fromBoardName: fromBoardName ?? this.fromBoardName,
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
      'fromUid': fromUid,
      'fromUserName': fromUserName,
      'fromBoardId': fromBoardId,
      'fromBoardName': fromBoardName,
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
      reviews_no: map['reviews_no'] != null ? map['reviews_no'] : 0,
      share_no: map['share_no'],
      trendiness: map['trendiness'],
      url: map['url'],
      demographic: map['demographic'],
      store: map['store'],
      occasion: map['occasion'],
      fromUid: map['fromUid'],
      fromUserName: map['fromUserName'],
      fromBoardId: map['fromBoardId'],
      fromBoardName: map['fromBoardName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(productId: $productId, brand: $brand, category: $category, description: $description, image: $image, title: $title, price: $price, rating: $rating, reviews_no: $reviews_no, share_no: $share_no, trendiness: $trendiness, url: $url, demographic: $demographic, store: $store, occasion: $occasion, fromUid: $fromUid, fromUserName: $fromUserName, fromBoardId: $fromBoardId, fromBoardName: $fromBoardName)';
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
        other.occasion == occasion &&
        other.fromUid == fromUid &&
        other.fromUserName == fromUserName &&
        other.fromBoardId == fromBoardId &&
        other.fromBoardName == fromBoardName;
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
        occasion.hashCode ^
        fromUid.hashCode ^
        fromUserName.hashCode ^
        fromBoardId.hashCode ^
        fromBoardName.hashCode;
  }

  factory Product.demo0() {
    return Product(
      productId: '',
      brand: "Monte Carlo",
      category: "t-shirt",
      description: "half-sleeve round neck black",
      image:
          "https://rukminim1.flixcart.com/image/880/1056/ju1jqfk0/t-shirt/u/z/4/l-men-ss19-rgln-hs-white-ylw-blk-strp-maniac-original-imaff9e8dpqzhwgu.jpeg?q=50",
      title: "MC t-shirt",
      price: 600,
      url:
          "https://www.flipkart.com/maniac-color-block-men-round-neck-white-black-yellow-t-shirt/p/itm82f2a149af9a8?pid=TSHFF9CCT5YB77ZW&lid=LSTTSHFF9CCT5YB77ZWRNMYT4&marketplace=FLIPKART&store=clo&srno=b_1_7&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_5_3.dealCard.OMU_4TGEXP57SSY8_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_5_NA_view-all_3&fm=neo%2Fmerchandising&iid=588c7929-575d-4981-9620-7af91cf4e3ad.TSHFF9CCT5YB77ZW.SEARCH&ppt=browse&ppn=browse&ssid=7kii9m4mds0000001632050949891",
      rating: 35,
      reviews_no: 205,
      trendiness: 44,
      demographic: 'demoId',
      occasion: 'brunch',
      share_no: 1,
      store: 'storeId',
      fromBoardId: null,
      fromBoardName: 'Board',
      fromUid: null,
      fromUserName: null,
    );
  }

  factory Product.demo1() {
    return Product(
      productId: '',
      brand: "Monte Carlo",
      category: "t-shirt",
      description: "half-sleeve round neck black",
      image:
          "https://rukminim1.flixcart.com/image/880/1056/ju1jqfk0/t-shirt/u/z/4/l-men-ss19-rgln-hs-white-ylw-blk-strp-maniac-original-imaff9e8dpqzhwgu.jpeg?q=50",
      title: "MC t-shirt",
      price: 600,
      url:
          "https://www.flipkart.com/maniac-color-block-men-round-neck-white-black-yellow-t-shirt/p/itm82f2a149af9a8?pid=TSHFF9CCT5YB77ZW&lid=LSTTSHFF9CCT5YB77ZWRNMYT4&marketplace=FLIPKART&store=clo&srno=b_1_7&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_5_3.dealCard.OMU_4TGEXP57SSY8_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_5_NA_view-all_3&fm=neo%2Fmerchandising&iid=588c7929-575d-4981-9620-7af91cf4e3ad.TSHFF9CCT5YB77ZW.SEARCH&ppt=browse&ppn=browse&ssid=7kii9m4mds0000001632050949891",
      rating: 35,
      reviews_no: 205,
      trendiness: 44,
      demographic: 'demoId',
      occasion: 'brunch',
      share_no: 1,
      store: 'storeId',
      fromBoardId: null,
      fromBoardName: null,
      fromUid: null,
      fromUserName: 'Aayush',
    );
  }
}
