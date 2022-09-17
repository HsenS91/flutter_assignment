// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      languageId: json['language_id'] as int?,
      nationalityId: json['nationality_id'] as int?,
      loginMethodId: json['login_method_id'] as int?,
      portalId: json['portal_id'] as int?,
      lastUserId: json['last_User_id'] as int?,
      userUserId: json['user_User_id'],
      userName: json['username'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profileImage: json['profile_image'] as String?,
      failedLoginAttempts: json['failed_login_attempts'] as int?,
      lastLoginDate: json['last_login_date'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'language_id': instance.languageId,
      'nationality_id': instance.nationalityId,
      'login_method_id': instance.loginMethodId,
      'portal_id': instance.portalId,
      'last_User_id': instance.lastUserId,
      'user_User_id': instance.userUserId,
      'username': instance.userName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'date_of_birth': instance.dateOfBirth,
      'phone_number': instance.phoneNumber,
      'profile_image': instance.profileImage,
      'failed_login_attempts': instance.failedLoginAttempts,
      'last_login_date': instance.lastLoginDate,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'roles': instance.roles,
    };
