import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel{

  @JsonKey(name: 'portal_id')
  final int? portalId;

  final String? email;

  final String? password;

  LoginModel({this.portalId,this.email, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

}