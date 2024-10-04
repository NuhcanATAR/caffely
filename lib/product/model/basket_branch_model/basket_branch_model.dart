import 'package:json_annotation/json_annotation.dart';
part 'basket_branch_model.g.dart';

@JsonSerializable()
class BasketBranchModel {
  final String id;
  final int basketTotal;
  final int totalQuanity;

  BasketBranchModel(this.id, this.basketTotal, this.totalQuanity);

  factory BasketBranchModel.fromJson(Map<String, dynamic> json) =>
      _$BasketBranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketBranchModelToJson(this);
}
