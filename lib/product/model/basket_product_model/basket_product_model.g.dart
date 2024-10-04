// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketProductModel _$BasketProductModelFromJson(Map<String, dynamic> json) =>
    BasketProductModel(
      json['id'] as String,
      (json['avaible'] as num).toInt(),
      (json['product_total'] as num).toInt(),
      json['product_id'] as String,
      (json['quanity'] as num).toInt(),
      (json['size'] as num).toInt(),
      (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$BasketProductModelToJson(BasketProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avaible': instance.avaible,
      'product_total': instance.productTotal,
      'product_id': instance.productId,
      'quanity': instance.quanity,
      'size': instance.size,
      'status': instance.status,
    };
