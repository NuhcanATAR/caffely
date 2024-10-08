// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['id'] as String,
      (json['adress_apartment_no'] as num).toInt(),
      json['adress_city'] as String,
      json['adress_directions'] as String,
      json['adress_district'] as String,
      (json['adress_floor'] as num).toInt(),
      json['adress_street'] as String,
      json['adress_title'] as String,
      json['contact_name'] as String,
      json['contact_surname'] as String,
      (json['contact_phone_number'] as num).toInt(),
      (json['payment_type'] as num).toInt(),
      json['user_id'] as String,
      const TimestampConverter().fromJson(json['date']),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adress_apartment_no': instance.adressApartmentNo,
      'adress_city': instance.adressCity,
      'adress_directions': instance.adressDirections,
      'adress_district': instance.adressDistrict,
      'adress_floor': instance.adressFloor,
      'adress_street': instance.adressStreet,
      'adress_title': instance.adressTitle,
      'contact_name': instance.contactName,
      'contact_surname': instance.contactSurname,
      'contact_phone_number': instance.contactPhoneNumber,
      'payment_type': instance.paymentType,
      'user_id': instance.userId,
      'date': const TimestampConverter().toJson(instance.date),
    };
