// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$PollLoginResponseFromJson(Map<String, dynamic> json) =>
    User(
      json['id'] as int?,
      json['custom_email'] as String?,
      json['social_email'] as String?,
      json['wallet_address'] as String?,
      json['wallet_nonce'] as String?,
      json['name'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['error'] as String?,
    );

Map<String, dynamic> _$PollLoginResponseToJson(User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'custom_email': instance.custom_email,
      'social_email': instance.social_email,
      'wallet_address': instance.wallet_address,
      'wallet_nonce': instance.wallet_nonce,
      'name': instance.name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'error': instance.error,
    };
