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

  Product(
      {required this.brand,
      required this.category,
      required this.desc,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.productUrl,
      required this.rating,
      required this.reviews,
      required this.trendiness});
}
