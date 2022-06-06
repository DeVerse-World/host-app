import 'package:deverse_host_app/data/models/DLevel.dart';
import 'package:deverse_host_app/data/models/verse_config.dart';
import 'package:flutter/material.dart';

class SessionManagerModel extends ChangeNotifier {
  List<VerseConfig> savedConfigs = [];

  DLevel? selectedLevel;
  void initData() {
    savedConfigs = [
      VerseConfig(1, DLevel(1, "Test"), "Nam", 8, 7777, 7877),
      VerseConfig(2, DLevel(2, "So 2"), "Hieu", 18, 7777, 7877),
      VerseConfig(3, DLevel(1, "Test"), "Thuan", 32, 7777, 7877),
    ];
  }

  void onSelectLevel(DLevel newLevel) {
    selectedLevel = newLevel;
    notifyListeners();
  }

  void onLaunchVerse(String verseName, String maxPlayerCount, String port, String beaconPort) {

  }


}