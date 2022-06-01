import 'package:deverse_host_app/data/models/DLevel.dart';
import 'package:flutter/material.dart';

class SessionManagerModel extends ChangeNotifier {
  DLevel? selectedLevel;
  void initData() {

  }

  void onSelectLevel(DLevel newLevel) {
    selectedLevel = newLevel;
    notifyListeners();
  }
}