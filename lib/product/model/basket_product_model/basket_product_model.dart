import 'package:json_annotation/json_annotation.dart';
part 'basket_product_model.g.dart';

@JsonSerializable()
class BasketProductModel {
  final String id;
  final int avaible;
  final int productTotal;
  final String productId;
  final String branchId;
  final int quanity;
  final int size;
  final int status;

  BasketProductModel({
    this.id = '',
    this.avaible = 0,
    this.productTotal = 0,
    this.productId = '',
    this.branchId = '',
    this.quanity = 0,
    this.size = 0,
    this.status = 0,
  });

  factory BasketProductModel.fromJson(Map<String, dynamic> json) =>
      _$BasketProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketProductModelToJson(this);

  Map<String, dynamic> toProductDocUpdate() {
    return {
      'quanity': quanity,
      'product_total': productTotal,
    };
  }

  Map<String, dynamic> toBranchProductSetFirebase() {
    return {
      'id': id,
      'avaible': avaible,
      'product_id': productId,
      'product_total': productTotal,
      'quanity': quanity,
      'size': size,
      'status': status,
      'branch_id': branchId,
    };
  }

  Map<String, dynamic> toBasketProductDocUpdate() {
    return {
      'id': id,
    };
  }
}
