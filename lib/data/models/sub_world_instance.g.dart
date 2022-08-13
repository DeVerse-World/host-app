// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_world_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubWorldInstance _$SubWorldInstanceFromJson(Map<String, dynamic> json) =>
    SubWorldInstance(
      json['id'] as int,
      json['host_name'] as String,
      json['region'] as String,
      json['max_players'] as int,
      json['num_current_players'] as int,
      json['instance_port'] as String,
      json['beacon_port'] as String,
      json['subworld_template_id'] as int,
      json['host_id'] as int,
      json['created_at'] as String,
      json['updated_at'] as String,
    );

Map<String, dynamic> _$SubWorldInstanceToJson(SubWorldInstance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'host_name': instance.host_name,
      'region': instance.region,
      'max_players': instance.max_players,
      'num_current_players': instance.num_current_players,
      'instance_port': instance.instance_port,
      'beacon_port': instance.beacon_port,
      'subworld_template_id': instance.subworld_template_id,
      'host_id': instance.host_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
