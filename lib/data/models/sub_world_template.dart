import 'package:json_annotation/json_annotation.dart';

part 'sub_world_template.g.dart';

@JsonSerializable()
class SubWorldTemplateData {
  List<SubWorldTemplate> subworld_templates = [];

  SubWorldTemplateData(this.subworld_templates);

  factory SubWorldTemplateData.fromJson(Map<String, dynamic> json) =>_$SubWorldTemplateDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubWorldTemplateDataToJson(this);
}

@JsonSerializable()
class SubWorldTemplate {
  int id = -1;
  String file_name = "";
  String display_name = "";
  String level_ipfs_uri = "";
  String level_centralized_uri = "";
  String thumbnail_centralized_uri = "";
  String derivative_uri = "";
  int? parent_subworld_template_id = null;
  int creator_id = -1;
  String created_at = "";
  String updated_at = "";

  SubWorldTemplate(this.id, this.file_name,
      this.display_name, this.level_ipfs_uri,
      this.level_centralized_uri, this.thumbnail_centralized_uri,
      this.derivative_uri, this.parent_subworld_template_id,
      this.creator_id, this.created_at, this.updated_at);

  factory SubWorldTemplate.fromJson(Map<String, dynamic> json) =>_$SubWorldTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$SubWorldTemplateToJson(this);
}