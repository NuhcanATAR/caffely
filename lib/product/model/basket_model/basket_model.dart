import 'package:json_annotation/json_annotation.dart';
part 'basket_model.g.dart';

@JsonSerializable()
class BasketModel {
  final String id;
  final int basketStatus;

  BasketModel(this.id, this.basketStatus);

  factory BasketModel.fromJson(Map<String, dynamic> json) =>
      _$BasketModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketModelToJson(this);
}
