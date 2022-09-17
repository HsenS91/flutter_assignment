import 'package:json_annotation/json_annotation.dart';

part 'pivot.g.dart';

@JsonSerializable()
class Pivot{

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'role_id')
  final int? roleId;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Pivot({this.userId, this.roleId, this.createdAt, this.updatedAt});

  factory Pivot.fromJson(Map<String, dynamic> json) =>
      _$PivotFromJson(json);

  Map<String, dynamic> toJson() => _$PivotToJson(this);
}