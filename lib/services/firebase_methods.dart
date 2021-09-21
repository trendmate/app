import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trendmate/models/product.dart';

class FirebaseMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseMethods _instance = FirebaseMethods._internal();
  static FirebaseMethods get instance => _instance;

  factory FirebaseMethods() {
    return _instance;
  }

  FirebaseMethods._internal();

  initFirebase() {}

  Future<List<Product>> getProducts() async {
    return (await _firestore.collection('trending_products').get())
        .docs
        .map((e) => Product.fromMap(e.data()))
        .toList();
  }

  // void setProducts() {
  //   List<Product> _products = [
  //     Product(
  //         brand: "Monte Carlo",
  //         category: "t-shirt",
  //         desc: "half-sleeve round neck black",
  //         imageUrl:
  //             "https://rukminim1.flixcart.com/image/880/1056/ju1jqfk0/t-shirt/u/z/4/l-men-ss19-rgln-hs-white-ylw-blk-strp-maniac-original-imaff9e8dpqzhwgu.jpeg?q=50",
  //         name: "MC t-shirt",
  //         price: 600,
  //         productUrl:
  //             "https://www.flipkart.com/maniac-color-block-men-round-neck-white-black-yellow-t-shirt/p/itm82f2a149af9a8?pid=TSHFF9CCT5YB77ZW&lid=LSTTSHFF9CCT5YB77ZWRNMYT4&marketplace=FLIPKART&store=clo&srno=b_1_7&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_5_3.dealCard.OMU_4TGEXP57SSY8_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_5_NA_view-all_3&fm=neo%2Fmerchandising&iid=588c7929-575d-4981-9620-7af91cf4e3ad.TSHFF9CCT5YB77ZW.SEARCH&ppt=browse&ppn=browse&ssid=7kii9m4mds0000001632050949891",
  //         rating: 3.5,
  //         reviews: 205,
  //         trendiness: 4.4),
  //     Product(
  //         brand: "Nike",
  //         category: "t-shirt",
  //         desc: "casual sneakers",
  //         imageUrl:
  //             "https://rukminim1.flixcart.com/image/880/1056/k8by93k0/t-shirt/4/k/d/xl-round-neck-half-sleeve-white-t-shirt-nb-nicky-boy-original-imafqctcwzagwjwg.jpeg?q=50",
  //         name: "Bata Shoes",
  //         price: 1201,
  //         productUrl:
  //             "https://www.flipkart.com/nb-nicky-boy-printed-men-round-neck-reversible-white-t-shirt/p/itmff2swdfd4vg8d?pid=TSHFF2PK9TA6FX6B&lid=LSTTSHFF2PK9TA6FX6BXQFGMR&marketplace=FLIPKART&q=tshirts+men&store=clo%2Fash%2Fank%2Fedy&srno=s_2_51&otracker=AS_QueryStore_OrganicAutoSuggest_1_4_na_na_na&otracker1=AS_QueryStore_OrganicAutoSuggest_1_4_na_na_na&fm=SEARCH&iid=00452920-e71f-4777-8015-aecd396d4c3a.TSHFF2PK9TA6FX6B.SEARCH&ppt=sp&ppn=sp&ssid=i9arnejl6o0000001632058297673&qH=ce85dd0df15cfd3a",
  //         rating: 4.1,
  //         reviews: 115,
  //         trendiness: 3.1)
  //   ];

  //   _firestore.collection('trending_products').doc().set(_products[0].toMap());
  //   _firestore.collection('trending_products').doc().set(_products[1].toMap());
  // }
}
