import 'package:flutter/material.dart';
import 'package:trendmate/models/filter.dart';

import 'package:trendmate/models/product.dart';
import 'package:trendmate/services/firebase_methods.dart';

class ProductsProvider with ChangeNotifier {
  static final ProductsProvider instance = ProductsProvider._internal();
  ProductsProvider._internal() {
    _init();
  }
  factory ProductsProvider() {
    return instance;
  }
  bool initilised = false;

  List<Product> _products = [];

  Future _init() async {
    if (!initilised) {
      _products = await FirebaseMethods.instance.getProducts();
      initilised = true;
      notifyListeners();
    }
  }

  Filter _filter = Filter(
      brands: ['Nike', 'Monte Carlo'],
      cats: ['t-shirt'],
      gender: ['M'],
      priceStart: 0,
      priceEnd: 5000,
      sites: []);

  Filter get filter => _filter;

  void setFilter(Filter newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  List<Product> get products {
    List<Product> curr = _products
        .where((element) =>
            _filter.brands.contains(element.brand) &&
            _filter.cats.contains(element.category) &&
            (_filter.priceStart <= element.price &&
                element.price <= _filter.priceEnd))
        .toList();
    curr.sort((a, b) => a.trendiness.compareTo(b.trendiness));

    return curr;
  }
}
