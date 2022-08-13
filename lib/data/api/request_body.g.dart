// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DResponse _$DResponseFromJson(Map<String, dynamic> json) => DResponse(
      json['message'] as String,
      json['data'],
      json['error'] as String?,
    );

Map<String, dynamic> _$DResponseToJson(DResponse instance) => <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'error': instance.error,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['login_url'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'login_url': instance.login_url,
    };

SubWorldRequest _$SubWorldRequestFromJson(Map<String, dynamic> json) =>
    SubWorldRequest(
      json['subworld_instance'] == null
          ? null
          : WorldInstanceConfig.fromJson(
              json['subworld_instance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubWorldRequestToJson(SubWorldRequest instance) =>
    <String, dynamic>{
      'subworld_instance': instance.subworld_instance,
    };

SubWorldTemplateData _$SubWorldTemplateDataFromJson(
        Map<String, dynamic> json) =>
    SubWorldTemplateData(
      (json['subworld_templates'] as List<dynamic>)
          .map((e) => SubWorldTemplate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubWorldTemplateDataToJson(
        SubWorldTemplateData instance) =>
    <String, dynamic>{
      'subworld_templates': instance.subworld_templates,
    };

SubWorldInstanceData _$SubWorldInstanceDataFromJson(
        Map<String, dynamic> json) =>
    SubWorldInstanceData(
      json['subworld_instance'] == null
          ? null
          : SubWorldInstance.fromJson(
              json['subworld_instance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubWorldInstanceDataToJson(
        SubWorldInstanceData instance) =>
    <String, dynamic>{
      'subworld_instance': instance.subworld_instance,
    };

SubWorldInstancesData _$SubWorldInstancesDataFromJson(
        Map<String, dynamic> json) =>
    SubWorldInstancesData(
      (json['subworld_instances'] as List<dynamic>?)
          ?.map((e) => SubWorldInstance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubWorldInstancesDataToJson(
        SubWorldInstancesData instance) =>
    <String, dynamic>{
      'subworld_instances': instance.subworld_instances,
    };
