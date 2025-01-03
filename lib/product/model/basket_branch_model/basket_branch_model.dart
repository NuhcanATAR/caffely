import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'basket_branch_model.g.dart';

@JsonSerializable()
class BasketBranchModel {
  final String id;
  final int basketTotal;
  final int totalQuanity;
  final int? status;

  BasketBranchModel({
    this.id = '',
    this.basketTotal = 0,
    this.totalQuanity = 0,
    this.status = 0,
  });

  factory BasketBranchModel.fromJson(Map<String, dynamic> json) =>
      _$BasketBranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketBranchModelToJson(this);

  Map<String, dynamic> toBranchDocUpdate() {
    return {
      'basket_total': FieldValue.increment(basketTotal),
      'total_quanity': FieldValue.increment(totalQuanity),
    };
  }

  Map<String, dynamic> toBranchAdd() {
    return {
      'id': id,
      'basket_total': basketTotal,
      'total_quanity': totalQuanity,
      'status': status,
    };
  }

  Map<String, dynamic> toBranchProductDocUpdate() {
    return {
      'basket_total': basketTotal,
      'total_quanity': totalQuanity,
      'status': status,
    };
  }
}
