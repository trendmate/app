import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:trendmate/constants/strings.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';
import 'package:trendmate/models/user.dart';

class FirebaseMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseMethods _instance = FirebaseMethods._internal();
  static FirebaseMethods get instance => _instance;

  factory FirebaseMethods() {
    return _instance;
  }

  FirebaseMethods._internal();

  Future<void> phoneAuth(
      String phone,
      Function(auth.PhoneAuthCredential credential) verCompleted,
      Function(auth.FirebaseAuthException e) verFailed) async {
    return await auth.FirebaseAuth.instance.verifyPhoneNumber(
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
    List<Product> result = [];

    final user = User.fromMap(
        (await _firestore.collection('users').doc(uid).get()).data()!);

    for (String board in user.my_boards) {
      result.addAll(await getPrductsOfBoard(board));
    }

    return result;
  }

  Future<List<Product>> getPrductsOfBoard(String boardId) async {
    List<Product> res = [];

    final board = Board.fromMap(
        (await _firestore.collection(StringConstants.BOARDS).doc(boardId).get())
            .data()!);

    for (String productId in board.products) {
      final prod = Product.fromMap((await _firestore
              .collection(StringConstants.PRODUCTS)
              .doc(productId)
              .get())
          .data()!);
      res.add(prod);
    }

    return res;
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

  Future<void> incrementShare(Product product) {
    return _firestore
        .collection(StringConstants.PRODUCTS)
        .doc(product.productId)
        .update({'share_no': product.share_no});
  }

  Future<List<User>> socialSearchPeople(String query) async {
    return (await _firestore
            .collection(StringConstants.USERS)
            .orderBy('name')
            .startAt([query]).endAt([query + "\uf8ff"]).get())
        .docs
        .map((e) => User.fromMap(e.data()))
        .toList();
  }

  Future<List<Board>> socialSearchBoards(String query) async {
    return (await _firestore
            .collection(StringConstants.BOARDS)
            .orderBy('title')
            .startAt([query]).endAt([query + "\uf8ff"]).get())
        .docs
        .map((e) => Board.fromMap(e.data()))
        .toList();
  }

  void demoData() {
    final doc = _firestore.collection(StringConstants.PRODUCTS).doc();
    Product _product = Product.demo0();
    _product.productId = doc.id;
    doc.set(_product.toMap());
  }
}
