// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      qrCodeId: json['qrcode_id'] as String,
      profileImage: json['profile_image'] as String,
      nameSurname: json['name_surname'] as String,
      email: json['email'] as String,
      phoneNumber: (json['phone_number'] as num).toInt(),
      city: json['city'] as String,
      district: json['district'] as String,
      authStatus: (json['auth_status'] as num).toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'qrcode_id': instance.qrCodeId,
      'profile_image': instance.profileImage,
      'name_surname': instance.nameSurname,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'city': instance.city,
      'district': instance.district,
      'authStatus': instance.authStatus,
    };
