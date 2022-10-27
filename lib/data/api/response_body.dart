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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserResponse {
  User user;

  UserResponse(this.user);
  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}