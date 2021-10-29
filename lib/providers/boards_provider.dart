import 'package:flutter/cupertino.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';

class BoardsProvider with ChangeNotifier {
  // Board id VS Board
  Map<String, Board> _boards = {};
  // product id VS list of Board Id
  Map<String, List<String>> _productsToBoards = {};

  void dummyInit() {
    // Product()
    _boards.putIfAbsent(
        "1",
        () => Board(boardId: "1", title: "board-1", image: "", favorites: {
              "productId": Product(
                  productId: "productId",
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

    _productsToBoards.putIfAbsent("productId", () => ["1"]);
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

    // var AllBoardIds = _boards.keys.toLi/st();
    Set<String> BoardIdsSet = {};
    for (int i = 0; i < BoardIds.length; i++) {
      BoardIdsSet.add(BoardIds[i]);
    }
    _boards.values.map((e) => !BoardIdsSet.contains(e.boardId)
        ? e.favorites.remove(ProductId)
        : null);
  }

  void addProductToBoard(String ProductId, String BoardId) {
    if (!_productsToBoards.containsKey(ProductId)) {
      _productsToBoards.putIfAbsent(ProductId, () => [BoardId]);
    } else {
      _productsToBoards.update(ProductId, (value) {
        value.add(BoardId);

        return value;
      });
    }
  }

  void removeProductFromBoard(String ProductId, String BoardId) {
    if (!_productsToBoards.containsKey(ProductId)) {
      return;
    } else {
      _productsToBoards.update(ProductId, (value) {
        value.remove(BoardId);

        return value;
      });
    }
  }

  List<String> listOfBoards(String productId) {
    return _productsToBoards[productId]!.toList();
  }

  List<String> allBoardIds() {
    return _boards.keys.toList();
  }

  Set<String> setOfBoards(String productId) {
    print(productId);
    print(_productsToBoards.entries.first.key);

    return _productsToBoards[productId]!.toSet();
  }
}
