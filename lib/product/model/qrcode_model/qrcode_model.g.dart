// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrcode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeModel _$QrCodeModelFromJson(Map<String, dynamic> json) => QrCodeModel(
      id: json['id'] as String,
      qrCode: json['qrcode_url'] as String,
    );

Map<String, dynamic> _$QrCodeModelToJson(QrCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrcode_url': instance.qrCode,
    };
