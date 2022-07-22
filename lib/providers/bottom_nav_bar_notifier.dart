import 'package:flutter/material.dart';

class BottomNavBarNotifier extends ChangeNotifier {
  int _currentTab = 0;

  int get currentTab => _currentTab;

  void setCurrentTab(int currentTab) {
    _currentTab = currentTab;
    notifyListeners();
  }
}
