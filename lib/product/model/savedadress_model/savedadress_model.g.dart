// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedadress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedAdressModel _$SavedAdressModelFromJson(Map<String, dynamic> json) =>
    SavedAdressModel(
      json['id'] as String,
      json['user_id'] as String,
      json['adress_title'] as String,
      json['adress_city'] as String,
      json['adress_district'] as String,
      json['adress_street'] as String,
      (json['adress_floor'] as num).toInt(),
      (json['adress_apartment_no'] as num).toInt(),
      json['adress_directions'] as String,
      json['contact_name'] as String,
      json['contact_surname'] as String,
      (json['contact_phone_number'] as num).toInt(),
      json['is_deleted'] as bool,
    );

Map<String, dynamic> _$SavedAdressModelToJson(SavedAdressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'adress_title': instance.adressTitle,
      'adress_city': instance.adressCity,
      'adress_district': instance.adressDistrict,
      'adress_street': instance.adressStreet,
      'adress_floor': instance.adressFloor,
      'adress_apartment_no': instance.adressAparmentNo,
      'adress_directions': instance.adressDirections,
      'contact_name': instance.contactName,
      'contact_surname': instance.contactSurname,
      'contact_phone_number': instance.contactPhoneNumber,
      'is_deleted': instance.isDeleted,
    };
