import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:trendmate/constants/strings.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';
import 'package:trendmate/models/social/post.dart';
import 'package:trendmate/models/user.dart';
import 'package:trendmate/providers/user_provider.dart';

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

  Future<bool> userExists(String phone) async {
    return (await _firestore
                .collection(StringConstants.USERS)
                .where('phone', isEqualTo: phone)
                .get())
            .docs
            .length >
        0;
  }

  Future<void> signUp(String name, String phone, String uid) {
    final user =
        User.demo().copyWith(name: name.toLowerCase(), phone: phone, uid: uid);

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

    final prodIds = (await _firestore
            .collection('users')
            .doc(uid)
            .collection(StringConstants.FAVORITES)
            .get())
        .docs
        .map((e) => e['productId'])
        .toList();

    for (String board in user.my_boards) {
      result.addAll(await getPrductsOfBoard(board));
    }

    for (String prod in prodIds) {
      result.add(await getProduct(prod));
    }

    return result;
  }

  Future<List<Board>> getBoards() async {
    return _firestore
        .collection(StringConstants.BOARDS)
        .get()
        .then((value) => value.docs
            .map((e) => Board.fromMap(e.data()
              ..addAll({
                'productId': e.id,
              })))
            .toList());
  }

  Future<Product> getProduct(String prod) async {
    return _firestore
        .collection(StringConstants.PRODUCTS)
        .doc(prod)
        .get()
        .then((value) => Product.fromMap(value.data()!
          ..addAll({
            'productId': prod,
          })));
  }

  Future<List<Product>> getPrductsOfBoard(String boardId) async {
    List<Product> res = [];

    final board = Board.fromMap(
        (await _firestore.collection(StringConstants.BOARDS).doc(boardId).get())
            .data()!);

    for (String productId in board.favorites) {
      print(productId);
      final prod = Product.fromMap((await _firestore
              .collection(StringConstants.PRODUCTS)
              .doc(productId)
              .get())
          .data()!
        ..addAll({
          'productId': productId,
        }));
      res.add(prod);
    }

    return res;
  }

  Future<void> followUser(User _user) {
    print(_user.uid);

    return _firestore.collection(StringConstants.USERS).doc(_user.uid).update({
      'friends': [_user.uid]
    });
  }

  Future<void> followBoard(String uid, Board board) {
    return _firestore.collection(StringConstants.USERS).doc(uid).update({
      'followed_boards': FieldValue.arrayUnion([board.boardId])
    });
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

  Future<List<Board>> getBaords(List<String> boardIds) async {
    List<Board> res = [];
    for (int i = 0; i < boardIds.length; i++) {
      final board = Board.fromMap((await _firestore
              .collection(StringConstants.BOARDS)
              .doc(boardIds[i])
              .get())
          .data()!);
      res.add(board);
    }

    return res;
  }

  Future<List<String>> getMyfavorites() {
    return _firestore
        .collection(StringConstants.USERS)
        .doc(UserProvider.instance.user!.uid)
        .collection(StringConstants.FAVORITES)
        .get()
        .then((value) =>
            value.docs.map((e) => e['productId'] as String).toList());
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

  Future<List<String>> getBrands() async {
    return (await _firestore.collection(StringConstants.BRANDS).get())
        .docs
        .map((e) => e.id)
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

  Future<String> addBoard(Board board, String uid) async {
    final doc = _firestore.collection(StringConstants.BOARDS).doc();
    board.boardId = doc.id;
    await _firestore.collection(StringConstants.USERS).doc(uid).update({
      'my_boards': FieldValue.arrayUnion([doc.id])
    });
    await doc.set(board.toMap());

    return doc.id;
  }

  Future<void> deleteBoard(String boardId) {
    return _firestore.collection(StringConstants.BOARDS).doc(boardId).delete();
  }

  Future<void> editBoard(String boardId, String title) {
    return _firestore.collection(StringConstants.BOARDS).doc(boardId).update({
      'title': title,
    });
  }

  Future<void> removeProductFromBoard(String productId, String boardId) {
    return _firestore.collection(StringConstants.BOARDS).doc(boardId).update({
      'favorites': FieldValue.arrayRemove([productId])
    });
  }

  Future<void> removeFavorites(String productId, String uid) {
    return _firestore
        .collection(StringConstants.USERS)
        .doc(uid)
        .collection(StringConstants.FAVORITES)
        .doc(productId)
        .delete();
  }

  Future<void> addFavorites(String productId, String uid) {
    return _firestore
        .collection(StringConstants.USERS)
        .doc(uid)
        .collection(StringConstants.FAVORITES)
        .doc(productId)
        .set({'productId': productId});
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
