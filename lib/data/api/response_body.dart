import 'package:json_annotation/json_annotation.dart';

part 'response_body.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? custom_email;
  String? social_email;
  String? wallet_address;
  String? wallet_nonce;
  String? name;
  String? created_at;
  String? updated_at;
  String? error;

  User(
      this.id, this.custom_email, this.social_email, this.wallet_address, this.wallet_nonce, this.name, this.created_at, this.updated_at, this.error);

  factory User.fromJson(Map<String, dynamic> json) => _$PollLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PollLoginResponseToJson(this);
}
