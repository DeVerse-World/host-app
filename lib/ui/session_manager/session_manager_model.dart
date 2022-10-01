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
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/db/app_storage.dart';

class SessionManagerModel extends BaseModel {
  final AppCache _appStorage = container<AppCache>();
  List<SubWorldTemplate> templates = [];
  final WorldTemplateRepository _worldTemplateRepository =
      container<WorldTemplateRepository>();
  final WorldInstanceRepository _worldInstanceRepository =
      container<WorldInstanceRepository>();

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
    loadConfigs().then((value) {
      logsContainer.addLog(jsonEncode(value));

      print(value);
      savedConfigs = value;
      notifyListeners();
    });
    // savedConfigs = [
    //   SubWorldConfig(1, SubWorldTheme(1, "Blizzard", "", "", "", 0, 0), "Nam",
    //       8, 7777, 7877),
    //   SubWorldConfig(2, SubWorldTheme(2, "Inferno", "", "", "", 0, 0), "Hieu",
    //       18, 7777, 7877),
    //   SubWorldConfig(3, SubWorldTheme(3, "Dungeon", "", "", "", 0, 0), "Thuan",
    //       32, 7777, 7877),
    //   SubWorldConfig(4, SubWorldTheme(4, "Dungeon", "", "", "", 0, 0), "Thuan",
    //       32, 7777, 7877),
    //   SubWorldConfig(5, SubWorldTheme(5, "Dungeon", "", "", "", 0, 0), "Thuan",
    //       32, 7777, 7877),
    //   SubWorldConfig(6, SubWorldTheme(6, "Blizzard", "", "", "", 0, 0), "Nam",
    //       8, 7777, 7877),
    //   SubWorldConfig(7, SubWorldTheme(7, "Inferno", "", "", "", 0, 0), "Hieu",
    //       18, 7777, 7877),
    //   SubWorldConfig(8, SubWorldTheme(8, "Dungeon", "", "", "", 0, 0), "Thuan",
    //       32, 7777, 7877),
    //   SubWorldConfig(9, SubWorldTheme(9, "Blizzard", "", "", "", 0, 0), "Nam",
    //       8, 7777, 7877),
    //   SubWorldConfig(10, SubWorldTheme(10, "Inferno", "", "", "", 0, 0), "Hieu",
    //       18, 7777, 7877),
    //   SubWorldConfig(11, SubWorldTheme(11, "Dungeon", "", "", "", 0, 0),
    //       "Thuan", 32, 7777, 7877),
    //   SubWorldConfig(12, SubWorldTheme(12, "Dungeon", "", "", "", 0, 0),
    //       "Thuan", 32, 7777, 7877),
    // ];
  }

  void onSelectTemplate(SubWorldTemplate template) {
    selectedTemplate = template;
    notifyListeners();
  }

  void onLaunchVerse(
      String verseName, String maxPlayerCount, String port, String beaconPort) {
    if (selectedTemplate == null ||
        verseName.isEmpty ||
        maxPlayerCount.isEmpty ||
        port.isEmpty ||
        beaconPort.isEmpty) {
      logsContainer.addLog(
          "Invalid Input, please check your inputs before launching a verse...");
      return;
    }
    _createInstance(verseName, maxPlayerCount, port, beaconPort,
        (int createdInstanceId) {
      _runServer(verseName, port, beaconPort, createdInstanceId);
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

  void _createInstance(String verseName, String maxPlayerCount, String port,
      String beaconPort, Function onInstanceCreated) {
    _worldInstanceRepository
        .createInstance(selectedTemplate!, verseName, "vn", maxPlayerCount,
            port, beaconPort)
        .then((res) {
      if (res.isFailure) {
        logsContainer.addLog(res.error.toString());
        return;
      }
      instances.add(res.data!);
      onInstanceCreated(res.data!.id);
    });
  }

  void _runServer(String verseName, String port, String beaconPort,
      int createdInstanceId) async {
    var path = "${Directory.current.path}/DeverseServer/DeverseServer.exe";
    if (kDebugMode) {
      path =
          "${Directory.current.path}/build/windows/runner/Debug/DeverseServer/DeverseServer.exe";
    }
    var process = await Process.start(
        path,
        [
          selectedTemplate!.file_name,
          "-log",
          "-Port=$port",
          "-BeaconPort=$beaconPort"
              "-IsMainVerse=deverse.world",
          "-DevVerse=dev.deverse.world",
          "-HostName=$verseName",
          "-ImageUrl=${selectedTemplate!.thumbnail_centralized_uri}",
          "-InstanceId=${createdInstanceId.toString()}",
          "-TemplateId=${selectedTemplate!.id.toString()}",
          "-ini:Engine:[EpicOnlineServices]:DedicatedServerClientId=${dotenv.env['EpicServerClientId']}",
          "-ini:Engine:[EpicOnlineServices]:DedicatedServerClientSecret=${dotenv.env['EpicServerClientSecret']}",
          "-ini:Engine:[EpicOnlineServices]:DedicatedServerPrivateKey=${dotenv.env['EpicServerPrivateKey']}"
              "&"
        ],
        runInShell: true);
    process.stdout.transform(utf8.decoder).forEach((element) {
      // print(element);
      // if (element.contains("Successfully")) {
      //   print("got here");
      //   var tokens = element.replaceAll("'", "").split(" ");
      //   var sessionID = tokens.last;
      //   print(sessionID);
      //   logsContainer.addLog("Successfully created session '$sessionID'");
      // }
      if (element.contains("Completed")) {
        notifyListeners();
      }
    });
    process.stderr.transform(utf8.decoder).forEach((element) {
      print(element);
    });
    process.exitCode.then((value) {
      var deletingInstance =
          instances.firstWhere((element) => element.id == createdInstanceId);
      instances.removeWhere((element) => element.id == createdInstanceId);
      onDeleteVerse(deletingInstance);
      logsContainer
          .addLog("Instance '$createdInstanceId' Instance was closed by user.");
      notifyListeners();
    });
  }

  void onSaveConfig(String verName, int maxCount, int port, int beacon) async {
    final configs = await loadConfigs();
    final config = SubWorldConfig(
        configs.length + 1,
        SubWorldTheme(configs.length + 1, "${verName} ${configs.length + 1}",
            "", "", "", 0, 0),
        verName,
        maxCount,
        port,
        beacon);
    configs.add(config);
    logsContainer.addLog("111${jsonEncode(configs)}");
    _appStorage.save("configs", jsonEncode(configs));
    savedConfigs = configs;
    notifyListeners();
  }

  Future<List<SubWorldConfig>> loadConfigs() async {
    final json = await _appStorage.get<String>("configs");
    if (json == null) return [];
    final configs = jsonDecode(json);
    return (configs as List<dynamic>)
        .map((e) => SubWorldConfig.fromJson(e))
        .toList();
  }
}
