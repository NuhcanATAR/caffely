// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['id'] as String,
      json['profile_image'] as String,
      json['name_surname'] as String,
      json['email'] as String,
      (json['phone_number'] as num).toInt(),
      json['city'] as String,
      json['district'] as String,
      (json['auth_status'] as num).toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'profile_image': instance.profileImage,
      'name_surname': instance.nameSurname,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'city': instance.city,
      'district': instance.district,
      'auth_status': instance.authStatus,
    };
