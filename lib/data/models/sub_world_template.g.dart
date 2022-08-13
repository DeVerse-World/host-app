// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_world_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubWorldTemplate _$SubWorldTemplateFromJson(Map<String, dynamic> json) =>
    SubWorldTemplate(
      json['id'] as int,
      json['file_name'] as String,
      json['display_name'] as String,
      json['level_ipfs_uri'] as String,
      json['level_centralized_uri'] as String,
      json['thumbnail_centralized_uri'] as String,
      json['derivative_uri'] as String,
      json['parent_subworld_template_id'] as int?,
      json['creator_id'] as int,
      json['created_at'] as String,
      json['updated_at'] as String,
    );

Map<String, dynamic> _$SubWorldTemplateToJson(SubWorldTemplate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file_name': instance.file_name,
      'display_name': instance.display_name,
      'level_ipfs_uri': instance.level_ipfs_uri,
      'level_centralized_uri': instance.level_centralized_uri,
      'thumbnail_centralized_uri': instance.thumbnail_centralized_uri,
      'derivative_uri': instance.derivative_uri,
      'parent_subworld_template_id': instance.parent_subworld_template_id,
      'creator_id': instance.creator_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
