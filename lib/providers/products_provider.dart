import 'package:flutter/material.dart';

import 'package:trendmate/models/ecom/filter.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/user.dart';
import 'package:trendmate/providers/user_provider.dart';
import 'package:trendmate/services/firebase_methods.dart';

class ProductsProvider with ChangeNotifier {
  ProductsProvider(UserProvider? provider) {
    _init(provider);
  }

  bool initilised = false;

  List<Product> _products = [];
  // Map<String, Product> _favorites = {};
  Set<String> _favoritesSet = {};
  List<String> _favoritesList = [];

  SocialProvider(UserProvider? provider) {
    _init(provider);
  }

  User? user;

  Future _init(UserProvider? provider) async {
    if (provider == null) return;
    if (!initilised || (provider.user != null && provider.user != user)) {
      _products = await FirebaseMethods.instance.getProducts();
      _favoritesList = await FirebaseMethods.instance.getMyfavorites();
      _favoritesSet = _favoritesList.toSet();
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
        .where((element) => _filter.brands[element.brand] == true
            // &&
            // _filter.cats[element.category] == true
            )
        .toList();
    curr.sort((a, b) => a.trendiness.compareTo(b.trendiness));

    return curr;
  }

  List<String> get favorites {
    return [..._favoritesList];
  }

  Set<String> get favoritesSet {
    return _favoritesSet;
  }

  // Future<void> addRemoveFavorites(int idx) async {
  //   if (_favorites.containsKey(_products[idx].productId)) {
  //     // await FirebaseMethods.instance.removeFavorites(_products[idx].productId);
  //     _favorites.remove(_products[idx].productId);
  //   } else {
  //     // await FirebaseMethods.instance.addFavorites(_products[idx].productId);
  //     _favorites.putIfAbsent(_products[idx].productId, () => _products[idx]);
  //   }
  //   notifyListeners();
  // }

  Future<void> removeFavorites(String productId) async {
    await FirebaseMethods.instance
        .removeFavorites(productId, UserProvider.instance.user!.uid);
    _favoritesSet.remove(productId);
    _favoritesList.remove(productId);
    notifyListeners();
  }

  Future<void> addFavorites(String productId) async {
    await FirebaseMethods.instance
        .addFavorites(productId, UserProvider.instance.user!.uid);
    _favoritesSet.add(productId);
    _favoritesList.add(productId);
    notifyListeners();
  }
}
