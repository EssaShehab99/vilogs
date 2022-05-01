import 'package:flutter/cupertino.dart';
import '/data/models/history.dart';

class HistoryManager extends ChangeNotifier {
  List<History> historyList = [];
  void setHistory(List<History> historyList){
    this.historyList=historyList;
    notifyListeners();
  }
}
