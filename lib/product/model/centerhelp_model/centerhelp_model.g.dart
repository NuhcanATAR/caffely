// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centerhelp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterHelpModel _$CenterHelpModelFromJson(Map<String, dynamic> json) =>
    CenterHelpModel(
      json['id'] as String,
      json['title'] as String,
      json['explanation'] as String,
      json['is_deleted'] as bool,
    );

Map<String, dynamic> _$CenterHelpModelToJson(CenterHelpModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'explanation': instance.explanation,
      'is_deleted': instance.isDeleted,
    };
