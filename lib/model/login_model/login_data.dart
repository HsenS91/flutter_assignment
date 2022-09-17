import 'package:json_annotation/json_annotation.dart';
import 'package:my_work/model/user/original.dart';

part 'login_data.g.dart';

@JsonSerializable()
class LoginData{

  final Original? original;

  LoginData({this.original});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}