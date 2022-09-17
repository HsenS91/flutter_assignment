import 'package:json_annotation/json_annotation.dart';
import 'package:my_work/model/user/pivot.dart';

part 'role.g.dart';

@JsonSerializable()
class Role{

  final int? id;

  @JsonKey(name: 'portal_id')
  final int? portalId;

  final String? name;

  @JsonKey(name: 'guard_name')
  final String? guardName;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  final Pivot? pivot;

  Role({
    this.id,
    this.portalId,
    this.name,
    this.guardName,
    this.createdAt,
    this.pivot
  });

  factory Role.fromJson(Map<String, dynamic> json) =>
      _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}