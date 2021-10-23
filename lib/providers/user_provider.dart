import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:trendmate/constants/config.dart';
import 'package:trendmate/models/user.dart';
import 'package:trendmate/services/firebase_methods.dart';

class UserProvider with ChangeNotifier {
  static final UserProvider instance = UserProvider._internal();
  UserProvider._internal() {
    _init();
  }
  factory UserProvider() {
    return instance;
  }
  bool initilised = false;

  User? user;

  Future _init() async {
    if (!initilised) {
      initilised = true;

      if (Config.UItest) {
        user = User.demo();
      }

      String? uid = auth.FirebaseAuth.instance.currentUser?.uid;
      if (uid != null)
        user = await FirebaseMethods.instance.getCurrentUser(uid);
      notifyListeners();
    }
  }
}
