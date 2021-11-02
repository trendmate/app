import 'package:flutter/cupertino.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';
import 'package:trendmate/services/firebase_methods.dart';

class BoardsProvider with ChangeNotifier {
  // Board id VS Board
  List<Board> _boards = [];
  // product id VS list of Board Id
  Map<String, List<String>> _productsToBoards = {};

  // void dummyInit() {
  //   // Product()
  //   _boards.putIfAbsent(
  //       "1",
  //       () => Board(boardId: "1", title: "board-1", image: "", favorites: {
  //             "productId": Product(
  //                 productId: "productId",
  //                 brand: "brand",
  //                 category: "category",
  //                 description: "description",
  //                 image: "image",
  //                 title: "title",
  //                 price: 10,
  //                 rating: 5,
  //                 reviews_no: 10,
  //                 share_no: 100,
  //                 trendiness: 10,
  //                 url:
  //                     "https://cdn.shopify.com/s/files/1/0070/7032/files/new-product-development-process.jpg?v=1600652722&width=1024",
  //                 demographic: "demographic",
  //                 store: "store",
  //                 occasion: "occasion",
  //                 fromUid: "fromUid",
  //                 fromUserName: "fromUserName",
  //                 fromBoardId: "fromBoardId",
  //                 fromBoardName: "fromBoardName")
  //           }));

  // _productsToBoards.putIfAbsent("productId", () => ["1"]);
  // }

  List<Board> get boardsList {
    return [..._boards];
  }

  Board? findByKey(String Key) {
    return _boards.firstWhere((element) => element.boardId == Key);
  }

  void createNewBoard(String name) {
    _boards.add(Board(boardId: name, title: name, image: "", favorites: []));
    notifyListeners();
  }

  // returns list of boardIds Associated with productID
  List<String> boardsOfProduct(String productId) {
    try {
      return _productsToBoards[productId]!.toList();
    } catch (e) {
      return [];
    }
  }

  void deleteBoard(String boardId) {
    int index = _boards.indexWhere((element) => element.boardId == boardId);
    List<String> productIds = _boards[index].favorites;
    for (int i = 0; i < productIds.length; i++) {
      _productsToBoards[productIds[i]]!.remove(boardId);
    }
    _boards.removeWhere((element) => element.boardId == boardId);
    notifyListeners();
  }

  void editBoardName(String boardId, String boardTitle) {
    int index = _boards.indexWhere((element) => element.boardId == boardId);
    _boards[index].title = boardTitle;
    notifyListeners();
  }

  void removeSingleProduct(String boardId, String productId) {
    int index = _boards.indexWhere((element) => element.boardId == boardId);
    _boards[index].favorites.remove(productId);
    _productsToBoards[productId]!.remove(boardId);
    notifyListeners();
  }

  void addSingleProduct(String boardId, String productId) {
    int index = _boards.indexWhere((element) => element.boardId == boardId);
    _boards[index].favorites.add(productId);
    _productsToBoards[productId]!.add(boardId);
    notifyListeners();
  }

  void addProduct(String productId, List<String> checkedBoardsIds) {
    for (int i = 0; i < _boards.length; i++) {
      if (_boards[i].favorites.contains(productId) &&
          !checkedBoardsIds.contains(_boards[i].boardId)) {
        removeSingleProduct(_boards[i].boardId, productId);
      } else if (!_boards[i].favorites.contains(productId) &&
          checkedBoardsIds.contains(_boards[i].boardId)) {
        addSingleProduct(_boards[i].boardId, productId);
      }
    }
    notifyListeners();
  }

}
