import 'package:flutter/cupertino.dart';
import 'package:trendmate/models/ecom/product.dart';

class BoardsProvider with ChangeNotifier {
  Map<String, Product> board = {};
  Map<String, Map<String, Product>> _boards = {};
}