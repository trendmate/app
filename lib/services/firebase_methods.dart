import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:trendmate/constants/strings.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';
import 'package:trendmate/models/social/post.dart';
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
      Function(auth.FirebaseAuthException e) verFailed,
      Function(String verificationId, int? resendToken) codeSent) async {
    return await auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + phone,
      verificationCompleted: verCompleted,
      verificationFailed: verFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signUp(String name, String phone, String uid) {
    final user = User.demo().copyWith(name: name, phone: phone, uid: uid);

    return _firestore
        .collection(StringConstants.USERS)
        .doc(uid)
        .set(user.toMap());
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

    // final board = Board.fromMap(
    //     (await _firestore.collection(StringConstants.BOARDS).doc(boardId).get())
    //         .data()!);

    // for (String productId in board.products) {
    //   final prod = Product.fromMap((await _firestore
    //           .collection(StringConstants.PRODUCTS)
    //           .doc(productId)
    //           .get())
    //       .data()!);
    //   res.add(prod);
    // }

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

  Future<List<Post>> getPosts() async {
    return (await _firestore.collection(StringConstants.POSTS).get())
        .docs
        .map((e) => Post.fromMap(e.data()
          ..addAll({
            'postId': e.id,
          })))
        .toList();
  }

  Future<void> incrementShare(Product product) {
    return _firestore
        .collection(StringConstants.PRODUCTS)
        .doc(product.productId)
        .update({'share_no': product.share_no});
  }

  Future<void> addProductToBoard(String productId, String boardId) {
    return _firestore.collection(StringConstants.BOARDS).doc(boardId).update({
      'favorites': FieldValue.arrayUnion([productId])
    });
  }

  Future<void> removeProductFromBoard(String productId, String boardId) {
    return _firestore.collection(StringConstants.BOARDS).doc(boardId).update({
      'favorites': FieldValue.arrayRemove([productId])
    });
  }

  Future<void> removeFavorites(String productId) {
    return _firestore
        .collection(StringConstants.BOARDS)
        .doc("favourites")
        .update({
      'favorites': FieldValue.arrayRemove([productId])
    });
  }

  Future<void> addFavorites(String productId) {
    return _firestore
        .collection(StringConstants.BOARDS)
        .doc("favourites")
        .update({
      'favorites': FieldValue.arrayRemove([productId])
    });
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
