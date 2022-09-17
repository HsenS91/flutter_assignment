import 'package:json_annotation/json_annotation.dart';
import 'package:my_work/model/login_model/login_data.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{

  final bool? success;
  final LoginData? data;
  final String? message;

  LoginResponse({this.success, this.data, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}