// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      portalId: json['portal_id'] as int?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      rememberMe: json['rememberMe'] as bool?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rememberMe', instance.rememberMe);
  val['portal_id'] = instance.portalId;
  val['email'] = instance.email;
  val['password'] = instance.password;
  return val;
}
