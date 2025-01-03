// ignore_for_file: avoid_dynamic_calls, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/products/product_detail/product_detail_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
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
    required this.basketProductList,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final BasketProductModel productModel;
  final BasketBranchModel branchesModel;
  final List<BasketProductModel> basketProducts;
  final List<BasketProductModel> basketProductList;

  @override
  State<ProductBasketCardWidget> createState() =>
      _ProductBasketCardWidgetState();
}

class _ProductBasketCardWidgetState extends BaseState<ProductBasketCardWidget> {
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
          return const SizedBox();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null) {
            return const SizedBox();
          }

          final ProductModel product = ProductModel.fromJson(
            data,
          );

          return Padding(
            padding: BaseUtility.horizontal(
              BaseUtility.paddingSmallValue,
            ),
            child: Row(
              children: <Widget>[
                // product image
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      CodeNoahNavigatorRouter.push(
                        context,
                        ProductDetailView(
                          productModel: product,
                        ),
                      );
                    },
                    child: SizedBox(
                      height: dynamicViewExtensions.dynamicHeight(
                        context,
                        0.11,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.coverImg.toString(),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                BaseUtility.radiusCircularMediumValue,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                BaseUtility.radiusCircularMediumValue,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                BaseUtility.radiusCircularMediumValue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // product information
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: BaseUtility.all(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        // title
                        SizedBox(
                          width: widget.dynamicViewExtensions.maxWidth(
                            context,
                          ),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      CodeNoahNavigatorRouter.push(
                                        context,
                                        ProductDetailView(
                                          productModel: product,
                                        ),
                                      );
                                    },
                                    child: TitleMediumBlackBoldText(
                                      text: product.title,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      context.read<BasketBloc>().productRemove(
                                            widget.branchesModel,
                                            widget.productModel,
                                            product,
                                            widget.basketProducts,
                                            context,
                                          ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.grey,
                                    size: BaseUtility.iconMediumSize,
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
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: BodyMediumMainColorText(
                              text:
                                  '${CodeNoahPriceConvert.formatPrice(widget.productModel.productTotal)}₺',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),

                        // size

                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(
                            context,
                          ),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: BodyMediumBlackText(
                                    text: AppLocalizations.of(context)!
                                        .product_basket_card_size,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: BodyMediumBlackText(
                                    text:
                                        ' ${widget.productModel.size == ProductTypeControl.middle.productTypeValue ? AppLocalizations.of(context)!.order_product_card_middle : widget.productModel.size == ProductTypeControl.large.productTypeValue ? AppLocalizations.of(context)!.order_product_card_large : AppLocalizations.of(context)!.order_product_card_small}',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // avaible
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(
                            context,
                          ),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: BodyMediumBlackText(
                                    text: AppLocalizations.of(context)!
                                        .product_basket_card_avaible,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: BodyMediumBlackText(
                                    text:
                                        ' ${widget.productModel.avaible == ProductCoffeAvaibleTypeControl.notSelect.coffeAvaibleTypeValue ? AppLocalizations.of(context)!.order_product_card_not_select : widget.productModel.avaible == ProductCoffeAvaibleTypeControl.hot.coffeAvaibleTypeValue ? AppLocalizations.of(context)!.order_product_card_hot : widget.productModel.avaible == ProductCoffeAvaibleTypeControl.ice.coffeAvaibleTypeValue ? AppLocalizations.of(context)!.order_product_card_ice : AppLocalizations.of(context)!.order_status_unknow}',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // quanity
                        Padding(
                          padding: BaseUtility.vertical(
                            BaseUtility.paddingSmallValue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              // add
                              GestureDetector(
                                onTap: () {
                                  context.read<BasketBloc>().productQuanityAdd(
                                        widget.branchesModel,
                                        widget.productModel,
                                        product,
                                        widget.basketProducts,
                                      );
                                },
                                child: Container(
                                  padding: BaseUtility.all(
                                    BaseUtility.paddingMediumValue,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outline,
                                      width: 0.5,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        BaseUtility.radiusLowValue,
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
                              Container(
                                padding: BaseUtility.horizontal(
                                  BaseUtility.paddingNormalValue,
                                ),
                                child: BodyMediumBlackText(
                                  text: widget.productModel.quanity.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // reduce
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<BasketBloc>()
                                      .productQuanityReduce(
                                        widget.branchesModel,
                                        widget.productModel,
                                        product,
                                        widget.basketProducts,
                                        context,
                                      );
                                },
                                child: Container(
                                  padding: BaseUtility.all(
                                    BaseUtility.paddingMediumValue,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outline,
                                      width: 0.5,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        BaseUtility.radiusLowValue,
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
