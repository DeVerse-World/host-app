// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_instance_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldInstanceConfig _$WorldInstanceConfigFromJson(Map<String, dynamic> json) =>
    WorldInstanceConfig(
      json['host_name'] as String,
      json['region'] as String,
      json['max_player'] as int,
      json['instance_port'] as String,
      json['beacon_port'] as String,
      json['subworld_template_id'] as int,
    );

Map<String, dynamic> _$WorldInstanceConfigToJson(
        WorldInstanceConfig instance) =>
    <String, dynamic>{
      'host_name': instance.host_name,
      'region': instance.region,
      'max_player': instance.max_player,
      'instance_port': instance.instance_port,
      'beacon_port': instance.beacon_port,
      'subworld_template_id': instance.subworld_template_id,
    };
