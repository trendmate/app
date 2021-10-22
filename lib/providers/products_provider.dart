import 'package:flutter/material.dart';

import 'package:trendmate/models/ecom/filter.dart';
import 'package:trendmate/models/ecom/product.dart';
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
  Map<String, Product> _favorites = {};

  Future _init() async {
    if (!initilised) {
      _products = await FirebaseMethods.instance.getProducts();
      initilised = true;
      notifyListeners();
    }
  }

  Filter _filter = Filter(
      brands: {"Monte Carlo": true, "Nike": true, "Gucci": false},
      gender: {"Men": true, "Women": true},
      cats: {"t-shirt": true, "shoes": true, "jeans": false},
      sites: {"myntra": true, "amazon": true, "flipkart": false},
      priceEnd: 3000,
      priceStart: 0);

  void setFilter(Filter newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  List<Product> get products {
    List<Product> curr = _products
        .where((element) =>
            _filter.brands[element.brand] == true &&
            _filter.cats[element.category] == true)
        .toList();
    curr.sort((a, b) => a.trendiness.compareTo(b.trendiness));

    return curr;
  }
  
  List<Product> get favorites {
    return [..._favorites.values];
  }

  Map<String, Product> get favoritesMap {
    return _favorites;
  }

  void addRemoveFavorites(int idx) {
    if (_favorites.containsKey(_products[idx].productId)) {
      _favorites.remove(_products[idx].productId);
    } else {
      _favorites.putIfAbsent(_products[idx].productId, () => _products[idx]);
    }
    notifyListeners();
  }
}
