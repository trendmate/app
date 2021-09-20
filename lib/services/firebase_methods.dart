import 'package:app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final FirebaseMethods instance = FirebaseMethods._internal();

  factory FirebaseMethods() {
    return instance;
  }

  FirebaseMethods._internal();

  initFirebase() {}

  Future getProducts() {
    return firestore.collection('trending_products').get();
  }
}
