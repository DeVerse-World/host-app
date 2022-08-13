import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String? id;
  String? custom_email;
  String? social_email;
  String? wallet_address;
  String? wallet_nonce;
  String? name;
  String? created_at;
  String? updated_at;

  User(this.id, this.custom_email, this.social_email, this.wallet_address,
      this.wallet_nonce, this.name, this.created_at, this.updated_at);
}