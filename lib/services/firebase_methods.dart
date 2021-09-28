import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trendmate/constants/strings.dart';
import 'package:trendmate/models/ecom/product.dart';

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
    return (await _firestore.collection(StringConstants.PRODUCTS).get())
        .docs
        .map((e) => Product.fromMap(e.data()))
        .toList();
  }

  void demoData() {
    Product _product = Product(
        brand: "Monte Carlo",
        category: "t-shirt",
        description: "half-sleeve round neck black",
        image:
            "https://rukminim1.flixcart.com/image/880/1056/ju1jqfk0/t-shirt/u/z/4/l-men-ss19-rgln-hs-white-ylw-blk-strp-maniac-original-imaff9e8dpqzhwgu.jpeg?q=50",
        title: "MC t-shirt",
        price: 600,
        url:
            "https://www.flipkart.com/maniac-color-block-men-round-neck-white-black-yellow-t-shirt/p/itm82f2a149af9a8?pid=TSHFF9CCT5YB77ZW&lid=LSTTSHFF9CCT5YB77ZWRNMYT4&marketplace=FLIPKART&store=clo&srno=b_1_7&otracker=hp_omu_Deals%2Bof%2Bthe%2BDay_5_3.dealCard.OMU_4TGEXP57SSY8_3&otracker1=hp_omu_SECTIONED_manualRanking_neo%2Fmerchandising_Deals%2Bof%2Bthe%2BDay_NA_dealCard_cc_5_NA_view-all_3&fm=neo%2Fmerchandising&iid=588c7929-575d-4981-9620-7af91cf4e3ad.TSHFF9CCT5YB77ZW.SEARCH&ppt=browse&ppn=browse&ssid=7kii9m4mds0000001632050949891",
        rating: 3.5,
        reviews_no: "205",
        trendiness: 4.4,
        demographic: 'demoId',
        occasion: 'brunch',
        productId: 'prodId',
        share_no: 1,
        store: 'storeId');

    _firestore.collection(StringConstants.PRODUCTS).doc().set(_product.toMap());
  }
}
