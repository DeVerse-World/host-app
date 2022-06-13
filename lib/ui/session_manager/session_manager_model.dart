import 'package:deverse_host_app/data/models/sub_world_theme.dart';
import 'package:deverse_host_app/data/models/sub_world_config.dart';
import 'package:flutter/material.dart';

class SessionManagerModel extends ChangeNotifier {
  List<SubWorldConfig> savedConfigs = [];

  SubWorldTheme? selectedLevel;
  void initData() {
    selectedLevel = null;
    savedConfigs = [
      SubWorldConfig(1, SubWorldTheme(1, "Blizzard", "", "", "", 0, 0), "Nam", 8, 7777, 7877),
      SubWorldConfig(2, SubWorldTheme(2, "Inferno", "", "", "", 0, 0), "Hieu", 18, 7777, 7877),
      SubWorldConfig(3, SubWorldTheme(3, "Dungeon", "", "", "", 0, 0), "Thuan", 32, 7777, 7877),
      SubWorldConfig(4, SubWorldTheme(4, "Dungeon", "", "", "", 0, 0), "Thuan", 32, 7777, 7877),
      SubWorldConfig(5, SubWorldTheme(5, "Dungeon", "", "", "", 0, 0), "Thuan", 32, 7777, 7877),
      SubWorldConfig(6, SubWorldTheme(6, "Blizzard", "", "", "", 0, 0), "Nam", 8, 7777, 7877),
      SubWorldConfig(7, SubWorldTheme(7, "Inferno", "", "", "", 0, 0), "Hieu", 18, 7777, 7877),
      SubWorldConfig(8, SubWorldTheme(8, "Dungeon", "", "", "", 0, 0), "Thuan", 32, 7777, 7877),
      SubWorldConfig(9, SubWorldTheme(9, "Blizzard", "", "", "", 0, 0), "Nam", 8, 7777, 7877),
      SubWorldConfig(10, SubWorldTheme(10, "Inferno", "", "", "", 0, 0), "Hieu", 18, 7777, 7877),
      SubWorldConfig(11, SubWorldTheme(11, "Dungeon", "", "", "", 0, 0), "Thuan", 32, 7777, 7877),
      SubWorldConfig(12, SubWorldTheme(12, "Dungeon", "", "", "", 0, 0), "Thuan", 32, 7777, 7877),
    ];
  }

  void onSelectLevel(SubWorldTheme newLevel) {
    selectedLevel = newLevel;
    notifyListeners();
  }

  void onLaunchVerse(String verseName, String maxPlayerCount, String port, String beaconPort) {

  }


}