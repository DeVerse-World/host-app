import 'package:json_annotation/json_annotation.dart';

part 'sub_world_instance.g.dart';

@JsonSerializable()
class SubWorldInstance {
  int id;
  String host_name;
  String region;
  int max_players;
  int num_current_players;
  String instance_port;
  String beacon_port;
  int subworld_template_id;
  int host_id;
  String created_at;
  String updated_at;

  SubWorldInstance(this.id, this.host_name, this.region, this.max_players, this.num_current_players, this.instance_port, this.beacon_port,
      this.subworld_template_id, this.host_id, this.created_at, this.updated_at);

  factory SubWorldInstance.fromJson(Map<String, dynamic> json) =>_$SubWorldInstanceFromJson(json);

  Map<String, dynamic> toJson() => _$SubWorldInstanceToJson(this);
}
