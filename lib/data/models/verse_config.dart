import 'package:deverse_host_app/data/models/DLevel.dart';

class VerseConfig {
  int id;
  DLevel level;
  String name;
  int maxPlayerCount;
  int port;
  int beaconPort;

  VerseConfig(this.id, this.level, this.name, this.maxPlayerCount, this.port, this.beaconPort);
}