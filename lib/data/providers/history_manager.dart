import 'package:flutter/cupertino.dart';
import 'package:vilogs/data/models/history.dart';

import '../models/user.dart';

class HistoryManager extends ChangeNotifier {
  List<History> historyList = [
    History(key: "Date",value: "2021/11/22"),
    History(key: "Speed",value: "100 mph"),
    History(key: "Airflow Rate",value: "101.3 kpa"),
    History(key: "Coolant Temperature",value: "180 degree"),
    History(key: "Engine Light",value: "Open"),
    History(key: "DTC",value: "P0430"),
    History(key: "No. Ignition Cycles",value: "26"),
  ];
}
