import 'package:flutter/cupertino.dart';

import '../../modules/history_page.dart';
import '../../modules/home_page.dart';
import '../../modules/issues_page.dart';
import '../../modules/menu_page.dart';
import '../../modules/realtime_data.dart';

class NavigationBarManager extends ChangeNotifier{
  int selectedIndex = 0;
  List<Widget> screens=[
    HomePage(),
    IssuesPage(),
    HistoryPage(),
    MenuPage(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}