// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'original.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Original _$OriginalFromJson(Map<String, dynamic> json) => Original(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresIn: json['expires_in'] as int?,
      user: (json['user'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OriginalToJson(Original instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'user': instance.user,
    };
