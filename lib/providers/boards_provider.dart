import 'package:flutter/cupertino.dart';
import 'package:trendmate/models/social/board.dart';

class BoardsProvider with ChangeNotifier {
  Map<String, Board> _boards = {};
}