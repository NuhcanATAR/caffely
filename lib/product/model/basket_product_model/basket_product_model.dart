import 'package:json_annotation/json_annotation.dart';
part 'basket_product_model.g.dart';

@JsonSerializable()
class BasketProductModel {
  final String id;
  final int avaible;
  final int productTotal;
  final String productId;
  final int quanity;
  final int size;
  final int status;

  BasketProductModel(
    this.id,
    this.avaible,
    this.productTotal,
    this.productId,
    this.quanity,
    this.size,
    this.status,
  );

  factory BasketProductModel.fromJson(Map<String, dynamic> json) =>
      _$BasketProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketProductModelToJson(this);
}
