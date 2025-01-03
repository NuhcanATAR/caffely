import 'package:json_annotation/json_annotation.dart';
part 'basket_model.g.dart';

@JsonSerializable()
class BasketModel {
  final String id;
  final int basketStatus;

  BasketModel({
    this.id = '',
    this.basketStatus = 0,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) =>
      _$BasketModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketModelToJson(this);

  Map<String, dynamic> toBasketSetFirebase() {
    return {
      'id': id,
      'basket_status': basketStatus,
    };
  }
}
