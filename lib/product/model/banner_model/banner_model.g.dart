// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      json['id'] as String,
      json['img'] as String,
      json['url'] as String,
      json['url_active'] as bool,
      json['status'] as bool,
      json['is_deleted'] as bool,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'url': instance.url,
      'url_active': instance.isUrl,
      'status': instance.status,
      'is_deleted': instance.isDeleted,
    };
