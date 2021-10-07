import 'package:flutter/material.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/user.dart';
import 'package:trendmate/providers/user_provider.dart';
import 'package:trendmate/services/firebase_methods.dart';

class SocialProvider with ChangeNotifier {
  static final SocialProvider instance = SocialProvider._internal();
  SocialProvider._internal() {
    _init();
  }
  factory SocialProvider() {
    return instance;
  }
  bool initilised = false;

  late User user;
  List<Product> prods = [];

  Future _init() async {
    if (!initilised) {
      initilised = true;
      user = UserProvider.instance.user!;
      for (String frnd in user.friends) {
        prods.addAll(await FirebaseMethods.instance.getLatestFavourites(frnd));
      }
      user.followed_boards;
      notifyListeners();
    }
  }
}
