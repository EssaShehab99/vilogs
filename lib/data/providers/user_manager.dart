import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserManager extends ChangeNotifier{
  User? _user;
  User? get getUser => _user;
  void setUser(User user) {
    this._user = user;
    // notifyListeners();
  }
}