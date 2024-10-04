// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketBranchModel _$BasketBranchModelFromJson(Map<String, dynamic> json) =>
    BasketBranchModel(
      json['id'] as String,
      (json['basket_total'] as num).toInt(),
      (json['total_quanity'] as num).toInt(),
    );

Map<String, dynamic> _$BasketBranchModelToJson(BasketBranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'basket_total': instance.basketTotal,
      'total_quanity': instance.totalQuanity,
    };
