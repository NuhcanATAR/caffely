// ignore_for_file: avoid_dynamic_calls

import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBasketCardWidget extends StatefulWidget {
  const ProductBasketCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.productModel,
    required this.branchesModel,
    required this.basketProducts,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final BasketProductModel productModel;
  final BasketBranchModel branchesModel;
  final List<BasketProductModel> basketProducts;

  @override
  State<ProductBasketCardWidget> createState() =>
      _ProductBasketCardWidgetState();
}

class _ProductBasketCardWidgetState extends State<ProductBasketCardWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseCollectionReferances.product.collectRef
          .doc(
            widget.productModel.productId,
          )
          .get(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return const SizedBox(
            child: Text(
              "Hatalı",
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            child: Text(
              "Yükleniyor",
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null) {
            return const SizedBox(
              child: Text(
                "Veri yok",
              ),
            );
          }

          final ProductModel product = ProductModel.fromJson(
            data,
          );

          return Padding(
            padding: PaddingSizedsUtility.horizontal(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: Column(
              children: <Widget>[
                // title
                SizedBox(
                  width: widget.dynamicViewExtensions.maxWidth(
                    context,
                  ),
                  child: Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.smallPaddingValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TitleMediumBlackBoldText(
                            text: product.title,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.read<BasketBloc>().productRemove(
                                widget.branchesModel,
                                widget.productModel,
                                product,
                                widget.basketProducts,
                                context,
                              ),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.grey,
                            size: IconSizedsUtility.mediumSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // price
                SizedBox(
                  width: widget.dynamicViewExtensions.maxWidth(
                    context,
                  ),
                  child: Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.smallPaddingValue,
                    ),
                    child: BodyMediumMainColorText(
                      text:
                          '${CodeNoahPriceConvert.formatPrice(widget.productModel.productTotal)}₺',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // quanity
                Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.smallPaddingValue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // add
                      GestureDetector(
                        onTap: () =>
                            context.read<BasketBloc>().productQuanityAdd(
                                  widget.branchesModel,
                                  widget.productModel,
                                  product,
                                  widget.basketProducts,
                                ),
                        child: Container(
                          padding: PaddingSizedsUtility.all(
                            PaddingSizedsUtility.mediumPaddingValue,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outline,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                RadiusUtility.lowRadiusValue,
                              ),
                            ),
                          ),
                          child: const BodyMediumBlackText(
                            text: '+',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // quanity
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: PaddingSizedsUtility.horizontal(
                            PaddingSizedsUtility.normalPaddingValue,
                          ),
                          child: BodyMediumBlackText(
                            text: widget.productModel.quanity.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // reduce
                      GestureDetector(
                        onTap: () =>
                            context.read<BasketBloc>().productQuanityReduce(
                                  widget.branchesModel,
                                  widget.productModel,
                                  product,
                                  widget.basketProducts,
                                  context,
                                ),
                        child: Container(
                          padding: PaddingSizedsUtility.all(
                            PaddingSizedsUtility.mediumPaddingValue,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outline,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                RadiusUtility.lowRadiusValue,
                              ),
                            ),
                          ),
                          child: const BodyMediumBlackText(
                            text: '-',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}