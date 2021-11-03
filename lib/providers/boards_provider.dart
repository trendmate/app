import 'package:flutter/cupertino.dart';
import 'package:trendmate/models/social/board.dart';
import 'package:trendmate/models/user.dart';
import 'package:trendmate/providers/user_provider.dart';
import 'package:trendmate/services/firebase_methods.dart';

class BoardsProvider with ChangeNotifier {
  BoardsProvider(UserProvider? provider) {
    _init(provider);
  }

  bool initilised = false;
  User? user;

  Future _init(UserProvider? provider) async {
    if (provider == null) return;
    if (!initilised || (provider.user != user && provider.user != null)) {
      initilised = true;
      _boards = await FirebaseMethods.instance.getBoards();
      notifyListeners();
    }
  }

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

  Future<void> createNewBoard(String name) async {
    final board = Board(
      uid: UserProvider.instance.user!.uid,
      title: name,
      image: "",
      favorites: [],
    );
    String id = await FirebaseMethods.instance.addBoard(board);
    board.boardId = id;
    _boards.add(board);
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

  Future<void> deleteBoard(String boardId) async {
    await FirebaseMethods.instance.deleteBoard(boardId);
    int index = _boards.indexWhere((element) => element.boardId == boardId);
    List<String> productIds = _boards[index].favorites;
    for (int i = 0; i < productIds.length; i++) {
      if (_productsToBoards.containsKey(productIds[i])) {
        _productsToBoards[productIds[i]]!.remove(boardId);
      }
    }
    _boards.removeWhere((element) => element.boardId == boardId);
    notifyListeners();
  }

  Future<void> editBoardName(String boardId, String boardTitle) async {
    FirebaseMethods.instance.editBoard(boardId, boardTitle);
    int index = _boards.indexWhere((element) => element.boardId == boardId);
    _boards[index].title = boardTitle;
    notifyListeners();
  }

  Future<void> removeSingleProduct(String boardId, String productId) async {
    await FirebaseMethods.instance.removeProductFromBoard(productId, boardId);
    int index = _boards.indexWhere((element) => element.boardId == boardId);
    _boards[index].favorites.remove(productId);
    if (_productsToBoards.containsKey(productId)) {
      _productsToBoards[productId]!.remove(boardId);
    }
    notifyListeners();
  }

  Future<void> addSingleProduct(String boardId, String productId) async {
    print(boardId);
    await FirebaseMethods.instance.addProductToBoard(productId, boardId);
    int index = _boards.indexWhere((element) => element.boardId == boardId);
    _boards[index].favorites.add(productId);
    if (_productsToBoards.containsKey(productId)) {
      _productsToBoards[productId]!.add(boardId);
    } else {
      _productsToBoards.putIfAbsent(productId, () => [boardId]);
    }
    notifyListeners();
  }

  // Future<void> addProduct(
  //     String productId, List<String> checkedBoardsIds) async {
  //   await FirebaseMethods.instance
  //       .addFavorites(productId, UserProvider.instance.user!.uid);
  //   for (int i = 0; i < _boards.length; i++) {
  //     if (_boards[i].favorites.contains(productId) &&
  //         !checkedBoardsIds.contains(_boards[i].boardId)) {
  //       removeSingleProduct(_boards[i].boardId!, productId);
  //     } else if (!_boards[i].favorites.contains(productId) &&
  //         checkedBoardsIds.contains(_boards[i].boardId)) {
  //       addSingleProduct(_boards[i].boardId!, productId);
  //     }
  //   }
  //   notifyListeners();
  // }
}
