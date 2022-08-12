import 'package:json_annotation/json_annotation.dart';

part 'world_instance_config.g.dart';

@JsonSerializable()
class WorldInstanceConfig {
  String host_name = "";
  String region = "";
  int max_player = 1;
  String instance_port = "";
  String beacon_port = "";
  int subworld_template_id = 1;

  WorldInstanceConfig(this.host_name, this.region, this.max_player, this.instance_port, this.beacon_port, this.subworld_template_id);

  factory WorldInstanceConfig.fromJson(Map<String, dynamic> json) =>_$WorldInstanceConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WorldInstanceConfigToJson(this);
}