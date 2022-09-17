import 'package:json_annotation/json_annotation.dart';
import 'package:my_work/model/user/user.dart';

part 'original.g.dart';

@JsonSerializable()
class Original{

  @JsonKey(name: 'access_token')
  final String? accessToken;

  @JsonKey(name: 'token_type')
  final String? tokenType;

  @JsonKey(name: 'expires_in')
  final int? expiresIn;

  final List<User>? user;

  Original({this.accessToken, this.tokenType, this.expiresIn, this.user});

  factory Original.fromJson(Map<String, dynamic> json) =>
      _$OriginalFromJson(json);

  Map<String, dynamic> toJson() => _$OriginalToJson(this);

}