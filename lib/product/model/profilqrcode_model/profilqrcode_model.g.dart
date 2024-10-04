// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilqrcode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileQRCodeModel _$ProfileQRCodeModelFromJson(Map<String, dynamic> json) =>
    ProfileQRCodeModel(
      json['id'] as String,
      json['user_id'] as String,
      json['qr_code'] as String,
      const TimestampConverter().fromJson(json['date']),
      json['is_deleted'] as bool,
    );

Map<String, dynamic> _$ProfileQRCodeModelToJson(ProfileQRCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'qr_code': instance.qrCode,
      'date': const TimestampConverter().toJson(instance.date),
      'is_deleted': instance.isDeleted,
    };
