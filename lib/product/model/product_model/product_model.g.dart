// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as String,
      json['store_id'] as String,
      json['cover_img'] as String,
      json['title'] as String,
      json['sub_title'] as String,
      json['description'] as String,
      (json['price'] as num).toInt(),
      (json['quanity'] as num).toInt(),
      json['is_showcase'] as bool,
      (json['product_type'] as num).toInt(),
      json['is_deleted'] as bool,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'cover_img': instance.coverImg,
      'title': instance.title,
      'sub_title': instance.subTitle,
      'description': instance.description,
      'price': instance.price,
      'quanity': instance.quanity,
      'is_showcase': instance.isShowCase,
      'product_type': instance.productType,
      'is_deleted': instance.isDeleted,
    };
