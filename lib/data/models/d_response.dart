import 'package:json_annotation/json_annotation.dart';

part 'd_response.g.dart';

@JsonSerializable()
class DResponse {
  String message = "";
  dynamic data;

  DResponse(this.message, this.data);

  factory DResponse.fromJson(Map<String, dynamic> json) =>_$DResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DResponseToJson(this);
}