import 'package:json_annotation/json_annotation.dart';

import '../models/sub_world_instance.dart';
import '../models/sub_world_template.dart';
import '../models/world_instance_config.dart';

part 'request_body.g.dart';

@JsonSerializable()
class DResponse {
  String message = "";
  dynamic data;
  String? error;
  DResponse(this.message, this.data, this.error);

  factory DResponse.fromJson(Map<String, dynamic> json) =>_$DResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DResponseToJson(this);
}

@JsonSerializable()
class LoginResponse {
  String login_url;
  LoginResponse(this.login_url);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>_$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class SubWorldRequest {
  WorldInstanceConfig? subworld_instance;

  SubWorldRequest(this.subworld_instance);

  factory SubWorldRequest.fromJson(Map<String, dynamic> json) =>_$SubWorldRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubWorldRequestToJson(this);
}

@JsonSerializable()
class SubWorldTemplateData {
  List<SubWorldTemplate> subworld_templates = [];

  SubWorldTemplateData(this.subworld_templates);

  factory SubWorldTemplateData.fromJson(Map<String, dynamic> json) =>_$SubWorldTemplateDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubWorldTemplateDataToJson(this);
}

@JsonSerializable()
class SubWorldInstanceData {
  SubWorldInstance? subworld_instance;

  SubWorldInstanceData(this.subworld_instance);

  factory SubWorldInstanceData.fromJson(Map<String, dynamic> json) =>_$SubWorldInstanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubWorldInstanceDataToJson(this);
}

@JsonSerializable()
class SubWorldInstancesData {
  List<SubWorldInstance>? subworld_instances;

  SubWorldInstancesData(this.subworld_instances);

  factory SubWorldInstancesData.fromJson(Map<String, dynamic> json) =>_$SubWorldInstancesDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubWorldInstancesDataToJson(this);
}