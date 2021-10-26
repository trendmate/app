import 'package:flutter/cupertino.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';

class BoardsProvider with ChangeNotifier {
  Map<String, Board> _boards = {};
  Map<String, List<String>> _productsToBoards = {};

  void dummyInit() {
    // Product()
    _boards.putIfAbsent(
        "1",
        () => Board(boardId: "1", title: "board-1", image: "", favorites: {
              "productId-1": Product(
                  productId: "productId-1",
                  brand: "brand",
                  category: "category",
                  description: "description",
                  image: "image",
                  title: "title",
                  price: 10,
                  rating: 5,
                  reviews_no: 10,
                  share_no: 100,
                  trendiness: 10,
                  url:
                      "https://cdn.shopify.com/s/files/1/0070/7032/files/new-product-development-process.jpg?v=1600652722&width=1024",
                  demographic: "demographic",
                  store: "store",
                  occasion: "occasion",
                  fromUid: "fromUid",
                  fromUserName: "fromUserName",
                  fromBoardId: "fromBoardId",
                  fromBoardName: "fromBoardName")
            }));

    _productsToBoards.putIfAbsent("productId-1", () => ["1"]);
  }

  Map<String, Board> get boardsMap {
    return _boards;
  }

  Board? findByKey(String Key) {
    return _boards[Key];
  }

  void createNewBoard(String name) {
    _boards.putIfAbsent(name,
        () => Board(boardId: name, title: name, image: "", favorites: {}));
  }

  // BoardIds is new updated list of current boards
  void updateBoards(String ProductId, List<String> BoardIds) {
    if (!_productsToBoards.containsKey(ProductId)) {
      _productsToBoards.putIfAbsent(ProductId, () => BoardIds);
    } else {
      if (BoardIds.length == 0) {
        _productsToBoards.remove(ProductId);
      } else {
        _productsToBoards.update(ProductId, (value) => BoardIds);
      }
    }
  }
}
