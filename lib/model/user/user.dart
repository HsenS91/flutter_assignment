import 'package:json_annotation/json_annotation.dart';
import 'package:my_work/model/user/role.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  final int? id;

  @JsonKey(name: 'language_id')
  final int? languageId;

  @JsonKey(name: 'nationality_id')
  final int? nationalityId;

  @JsonKey(name: 'login_method_id')
  final int? loginMethodId;

  @JsonKey(name: 'portal_id')
  final int? portalId;

  @JsonKey(name: 'last_User_id')
  final int? lastUserId;

  @JsonKey(name: 'user_User_id')
  final userUserId;

  // @JsonKey(name: 'social_id')
  // final socialId;

  @JsonKey(name: 'username')
  final String? userName;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  final String? email;

  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;

  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'profile_image')
  final String? profileImage;

  @JsonKey(name: 'failed_login_attempts')
  final int? failedLoginAttempts;

  @JsonKey(name: 'last_login_date')
  final String? lastLoginDate;

  // @JsonKey(name: 'failed_login_attempt_time')
  // final failedLoginAttemptTime;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  // @JsonKey(name: 'deleted_at')
  // final deletedAt;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  final List<Role>? roles;

  User({
    this.id,
    this.languageId,
    this.nationalityId,
    this.loginMethodId,
    this.portalId,
    this.lastUserId,
    this.userUserId,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.dateOfBirth,
    this.phoneNumber,
    this.profileImage,
    this.failedLoginAttempts,
    this.lastLoginDate,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.roles
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}