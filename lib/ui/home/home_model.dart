import 'package:deverse_host_app/data/models/DLevel.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  List<DLevel> verseLevels = [];
  DLevel? selectedLevel;
  void initData() {
    verseLevels = [
      DLevel(1, "Map 1"),
      DLevel(2, "Map 2"),
      DLevel(3, "Map 31"),
    ];
    notifyListeners();
  }

  void selectLevel(DLevel newLevel) {
    selectedLevel = newLevel;
    notifyListeners();
  }
}