// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketProductModel _$BasketProductModelFromJson(Map<String, dynamic> json) =>
    BasketProductModel(
      id: json['id'] as String,
      avaible: (json['avaible'] as num).toInt(),
      productTotal: (json['product_total'] as num).toInt(),
      productId: json['product_id'] as String,
      branchId: json['branch_id'] as String,
      quanity: (json['quanity'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$BasketProductModelToJson(BasketProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avaible': instance.avaible,
      'product_total': instance.productTotal,
      'product_id': instance.productId,
      'branch_id': instance.branchId,
      'quanity': instance.quanity,
      'size': instance.size,
      'status': instance.status,
    };
