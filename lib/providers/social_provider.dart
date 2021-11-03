import 'package:flutter/material.dart';
import 'package:trendmate/constants/config.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';
import 'package:trendmate/models/user.dart';
import 'package:trendmate/providers/user_provider.dart';
import 'package:trendmate/services/firebase_methods.dart';

class SocialProvider with ChangeNotifier {
  SocialProvider(UserProvider? provider) {
    _init(provider);
  }

  bool initilised = false;

  List<Product> prods = [];

  List<Board> searchingBoards = [];
  List<User> searchedUsers = [];

  User? user;

  Future _init(UserProvider? provider) async {
    if (provider == null) return;
    if (!initilised || provider.user != user) {
      initilised = true;

      if (Config.UItest) {
        prods = [
          Product.demo0(),
          Product.demo1(),
        ];
      }

      if (UserProvider.instance.user == null) return;

      user = UserProvider.instance.user!;
      for (String frnd in user!.friends) {
        if (frnd.isNotEmpty)
          prods
              .addAll(await FirebaseMethods.instance.getLatestFavourites(frnd));
      }
      for (String boardId in user!.followed_boards) {
        if (boardId.isNotEmpty)
          prods.addAll(
              await FirebaseMethods.instance.getPrductsOfBoard(boardId));
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

  Future<void> followUser(User _user) async {
    await FirebaseMethods.instance.followUser(_user);
    user!.friends.add(_user.uid);

    notifyListeners();
  }

  Future<void> followBoard(Board _board) async {
    await FirebaseMethods.instance
        .followBoard(UserProvider.instance.user!.uid, _board);
    UserProvider.instance.user!.followed_boards.add(_board.boardId!);

    notifyListeners();
  }
}
