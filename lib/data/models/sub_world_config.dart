import 'package:deverse_host_app/data/models/sub_world_theme.dart';

class SubWorldConfig {
  int id;
  SubWorldTheme level;
  String name;
  int maxPlayerCount;
  int port;
  int beaconPort;

  SubWorldConfig(this.id, this.level, this.name, this.maxPlayerCount, this.port,
      this.beaconPort);

  SubWorldConfig.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        level = SubWorldTheme.fromJson(json['level']),
        maxPlayerCount = json['maxPlayerCount'],
        port = json['port'],
        beaconPort = json['beaconPort'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'level': level.toJson(),
        'name': name,
        'maxPlayerCount': maxPlayerCount,
        'port': port,
        'beaconPort': beaconPort,
      };
}
