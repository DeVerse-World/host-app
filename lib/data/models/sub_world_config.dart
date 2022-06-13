import 'package:deverse_host_app/data/models/sub_world_theme.dart';

class SubWorldConfig {
  int id;
  SubWorldTheme level;
  String name;
  int maxPlayerCount;
  int port;
  int beaconPort;

  SubWorldConfig(this.id, this.level, this.name, this.maxPlayerCount, this.port, this.beaconPort);
}