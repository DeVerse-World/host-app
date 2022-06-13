import 'package:deverse_host_app/data/models/sub_world_theme.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  List<SubWorldTheme> verseLevels = [];
  List<SubWorldTheme> selectedLevels = [];

  void initData() {
    verseLevels = [
      SubWorldTheme(1, "Blizzard", "Blizzard", "", "", 0, 0),
      SubWorldTheme(2, "Inferno", "Inferno", "", "", 0, 0),
      SubWorldTheme(3, "Dungeon", "Dungeon", "", "", 0, 0),
    ];
  }

  bool get isAllSelected {
    return verseLevels.length == selectedLevels.length;
  }

  bool isLevelSelected(SubWorldTheme level) {
    return selectedLevels.contains(level);
  }

  void onToggleSelection(SubWorldTheme newLevel, bool isSelected) {
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
