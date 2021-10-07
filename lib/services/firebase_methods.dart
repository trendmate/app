import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:trendmate/constants/strings.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/user.dart';

class FirebaseMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseMethods _instance = FirebaseMethods._internal();
  static FirebaseMethods get instance => _instance;

  factory FirebaseMethods() {
    return _instance;
  }

  FirebaseMethods._internal();

  void phoneAuth(
      String phone,
      Function(auth.PhoneAuthCredential credential) verCompleted,
      Function(auth.FirebaseAuthException e) verFailed) async {
    await auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + phone,
      verificationCompleted: verCompleted,
      verificationFailed: verFailed,
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<User> getCurrentUser(String uid) async {
    return User.fromMap(
        (await _firestore.collection('users').doc(uid).get()).data()!);
  }

  Future<List<Product>> getLatestFavourites(String uid) async {
    final user = User.fromMap(
        (await _firestore.collection('users').doc(uid).get()).data()!);

    return [];
  }

  Future<List<Product>> getProducts() async {
    return (await _firestore.collection(StringConstants.PRODUCTS).get())
        .docs
        .map((e) => Product.fromMap(e.data()
          ..addAll({
            'productId': e.id,
          })))
        .toList();
  }

  void demoData() {
    final doc = _firestore.collection(StringConstants.PRODUCTS).doc();
    Product _product = Product(
      productId: doc.id,
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
      fromUserName: null,
    );

    doc.set(_product.toMap());
  }
}
