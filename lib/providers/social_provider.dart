import 'package:flutter/material.dart';
import 'package:trendmate/constants/config.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';
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

  List<Product> prods = [];

  List<Board> searchingBoards = [];
  List<User> searchedUsers = [];

  Future _init() async {
    if (!initilised) {
      initilised = true;

      if (Config.UItest) {
        prods = [
          Product.demo0(),
          Product.demo1(),
        ];
      }

      if (UserProvider.instance.user == null) return;

      final user = UserProvider.instance.user!;
      for (String frnd in user.friends) {
        prods.addAll(await FirebaseMethods.instance.getLatestFavourites(frnd));
      }
      for (String boardId in user.followed_boards) {
        prods.addAll(await FirebaseMethods.instance.getPrductsOfBoard(boardId));
      }
      notifyListeners();
    }
  }

  Future<void> incrementShare(Product product) async {
    product.share_no++;
    if (!Config.UItest) await FirebaseMethods.instance.incrementShare(product);

    notifyListeners();
  }

  Future<void> setSearchText(String query) async {
    searchingBoards = await FirebaseMethods.instance.socialSearchBoards(query);
    searchedUsers = await FirebaseMethods.instance.socialSearchPeople(query);

    notifyListeners();
  }
}
