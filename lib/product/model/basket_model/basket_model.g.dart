// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketModel _$BasketModelFromJson(Map<String, dynamic> json) => BasketModel(
      json['id'] as String,
      (json['basket_status'] as num).toInt(),
    );

Map<String, dynamic> _$BasketModelToJson(BasketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'basket_status': instance.basketStatus,
    };