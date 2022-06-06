import 'package:deverse_host_app/data/models/DLevel.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  List<DLevel> verseLevels = [];
  List<DLevel> selectedLevels = [];
  void initData() {
    verseLevels = [
      DLevel(1, "Blizzard"),
      DLevel(2, "Inferno"),
      DLevel(3, "Dungeon"),
    ];
  }

  bool get isAllSelected {
    return verseLevels.length == selectedLevels.length;
  }

  bool isLevelSelected(DLevel level) {
    return selectedLevels.contains(level);
  }

  void onToggleSelection(DLevel newLevel, bool isSelected) {
    if (isSelected) {
      selectedLevels.add(newLevel);
    } else {
      selectedLevels.remove(newLevel);
    }
    notifyListeners();
  }

  void onToggleAllLevel(bool isSelected) {
    selectedLevels = [];
    if (isSelected) {
      for (var element in verseLevels) {
        selectedLevels.add(element);
      }
    }
    notifyListeners();
  }
  // void selectLevel(DLevel newLevel) {
  //   notifyListeners();
  // }
}