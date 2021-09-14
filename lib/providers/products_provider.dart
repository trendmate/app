import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  static final ProductsProvider instance = ProductsProvider._internal();
  ProductsProvider._internal() {
    _init();
  }
  factory ProductsProvider() {
    return instance;
  }
  bool initilised = false;

  Future _init() async {
    if (!initilised) {
      initilised = true;
      notifyListeners();
    }
  }
}
