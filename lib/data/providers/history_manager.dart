import 'package:flutter/cupertino.dart';
import 'package:vilogs/data/models/history.dart';

import '../models/user.dart';

class HistoryManager extends ChangeNotifier {
  List<History> historyList = [];

  void setHistory(List<History> historyList){
    this.historyList=historyList;
    notifyListeners();
  }
}
