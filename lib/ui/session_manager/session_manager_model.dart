import 'dart:convert';
import 'dart:io';

import 'package:deverse_host_app/data/models/sub_world_config.dart';
import 'package:deverse_host_app/data/models/sub_world_instance.dart';
import 'package:deverse_host_app/data/models/sub_world_template.dart';
import 'package:deverse_host_app/data/models/sub_world_theme.dart';
import 'package:deverse_host_app/repositories/world_instance_repository.dart';
import 'package:deverse_host_app/repositories/world_template_repository.dart';
import 'package:deverse_host_app/ui/base_change_notifier.dart';
import 'package:deverse_host_app/utils/injection_container.dart';
import 'package:flutter/foundation.dart';

class SessionManagerModel extends BaseModel {
  List<SubWorldTemplate> templates = [];
  final WorldTemplateRepository _worldTemplateRepository = container<WorldTemplateRepository>();
  final WorldInstanceRepository _worldInstanceRepository = container<WorldInstanceRepository>();

  List<SubWorldConfig> savedConfigs = [];
  SubWorldTemplate? selectedTemplate;
  List<SubWorldInstance> instances = [];

  void initData(SubWorldTemplate rootTemplate) {
    _worldTemplateRepository.getSubTemplates(rootTemplate).then((value) {
      templates = value;
      notifyListeners();
    });
    _worldInstanceRepository.fetchInstances().then((value) {
      instances = value;
      notifyListeners();
    });
    selectedTemplate = null;
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

  void onSelectTemplate(SubWorldTemplate template) {
    selectedTemplate = template;
    notifyListeners();
  }

  Future<void> onLaunchVerse(String verseName, String maxPlayerCount, String port, String beaconPort) async {
    if (selectedTemplate == null || verseName.isEmpty || maxPlayerCount.isEmpty || port.isEmpty || beaconPort.isEmpty) {
      logsContainer.addLog("Invalid Input, please check your inputs before launching a verse...");
      return;
    }
    _runServer(verseName, maxPlayerCount, () {
      _worldInstanceRepository.createInstance(selectedTemplate!, verseName, "vn", maxPlayerCount, port, beaconPort).then((res) {
        if (res.isFailure) {
          logsContainer.addLog(res.error.toString());
          return;
        }
        instances.add(res.data!);
        notifyListeners();
      });
    });

  }

  void onDeleteVerse(SubWorldInstance subWorldInstance) {
    _worldInstanceRepository.deleteInstance(subWorldInstance).then((value) {
      if (value.isSuccess) {
        instances.removeWhere((element) => element.id == subWorldInstance.id);
        notifyListeners();
      }
    });
  }

  void _runServer(String verseName, String port, Function onServerStarted) {
    var path = "DeverseServer.exe";
    if (kDebugMode) {
      path = "C:/Projects/Deverse_host_app/build/windows/runner/Debug/$path";
    }
    Process.start(
        path,
        [
          "\"$verseName\"",
          "-log",
          "-port=$port",
          "-IsMainVerse",
          "deverse.world",
          "DevVerse",
          "dev.deverse.world",
          "-ImageUrl",
          selectedTemplate!.thumbnail_centralized_uri,
          "-ini:Engine:[EpicOnlineServices]:DedicatedServerClientId=xyza78918lRFdOzrwsYpy0UAYOL9aczp",
          "-ini:Engine:[EpicOnlineServices]:DedicatedServerClientSecret=AbOM+j2USFaRzR0/bslO5g/7E4/IMlJ/GazcT3PdbjU",
          "-ini:Engine:[EpicOnlineServices]:DedicatedServerPrivateKey=syH/1RLIAil5pSrifb/xjDmfd9j9bhAfVuPLv9AE0uHDPXK8kPxJIIs4gvwNXFfVhM4XR4YrNNPrFxy3UCluCQ=="
              "&"
        ],
        runInShell: true)
        .then((process) {
          process.stdout.transform(utf8.decoder).forEach((element) {
            if (element.contains("Completed")) {
              onServerStarted.call();
            }
          });
      // logsContainer.addLog(value.);

    }).catchError((e) {
      logsContainer.addLog(e.toString());
    });
  }
}
