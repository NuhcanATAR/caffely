import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String storeId;
  final String coverImg;
  final String title;
  final String subTitle;
  final String description;
  final int price;

  final int middlePrice;
  final int largePrice;
  final int quanity;
  final bool isShowCase;
  final int productType;
  final bool isDeleted;

  ProductModel(
    this.id,
    this.storeId,
    this.coverImg,
    this.title,
    this.subTitle,
    this.description,
    this.price,
    this.middlePrice,
    this.largePrice,
    this.quanity,
    this.isShowCase,
    this.productType,
    this.isDeleted,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
