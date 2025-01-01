// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/feature/products/product_detail/productdetail_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:flutter/material.dart';

class OrderProductCardWidget extends StatelessWidget {
  const OrderProductCardWidget({
    super.key,
    required this.productModel,
    required this.dynamicViewExtensions,
    required this.basketProductModel,
  });

  final ProductModel productModel;
  final DynamicViewExtensions dynamicViewExtensions;
  final BasketProductModel basketProductModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BaseUtility.top(
        BaseUtility.paddingNormalValue,
      ),
      child: GestureDetector(
        onTap: () {
          CodeNoahNavigatorRouter.push(
            context,
            ProductDetailView(
              productModel: productModel,
            ),
          );
        },
        child: Container(
          padding: BaseUtility.all(
            BaseUtility.paddingSmallValue,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                BaseUtility.radiusCircularMediumValue,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              // product image
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: SizedBox(
                  height: dynamicViewExtensions.dynamicHeight(
                    context,
                    0.11,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: productModel.coverImg.toString(),
                    imageBuilder: (
                      context,
                      imageProvider,
                    ) =>
                        Container(
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
              // body
              Expanded(
                flex: 5,
                child: Padding(
                  padding: BaseUtility.horizontal(
                    BaseUtility.paddingNormalValue,
                  ),
                  child: Column(
                    children: <Widget>[
                      // title
                      SizedBox(
                        width: dynamicViewExtensions.maxWidth(
                          context,
                        ),
                        child: Padding(
                          padding: BaseUtility.vertical(
                            BaseUtility.paddingSmallValue,
                          ),
                          child: TitleMediumBlackBoldText(
                            text: productModel.title,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      // quanity
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
                                      .order_product_card_quanity,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: BodyMediumBlackText(
                                  text: 'Adet ${basketProductModel.quanity}x',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
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
                                      .order_product_card_size,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: BodyMediumBlackText(
                                  text:
                                      ' ${basketProductModel.size == ProductTypeControl.middle.productTypeValue ? AppLocalizations.of(context)!.order_product_card_middle : basketProductModel.size == ProductTypeControl.large.productTypeValue ? AppLocalizations.of(context)!.order_product_card_large : AppLocalizations.of(context)!.order_product_card_small}',
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
                                      .order_product_card_avaible,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: BodyMediumBlackText(
                                  text:
                                      ' ${basketProductModel.avaible == ProductCoffeAvaibleTypeControl.notSelect.coffeAvaibleTypeValue ? AppLocalizations.of(context)!.order_product_card_not_select : basketProductModel.avaible == ProductCoffeAvaibleTypeControl.hot.coffeAvaibleTypeValue ? AppLocalizations.of(context)!.order_product_card_hot : basketProductModel.avaible == ProductCoffeAvaibleTypeControl.ice.coffeAvaibleTypeValue ? AppLocalizations.of(context)!.order_product_card_ice : AppLocalizations.of(context)!.order_status_unknow}',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // price
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
                                child: BodyMediumMainColorText(
                                  text: AppLocalizations.of(context)!
                                      .order_product_card_price,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: BodyMediumMainColorBoldText(
                                  text: '${CodeNoahPriceConvert.formatPrice(
                                    basketProductModel.size ==
                                            ProductTypeControl
                                                .middle.productTypeValue
                                        ? productModel.price +
                                            productModel.middlePrice
                                        : basketProductModel.size ==
                                                ProductTypeControl
                                                    .large.productTypeValue
                                            ? productModel.price +
                                                productModel.largePrice
                                            : productModel.price,
                                  )}₺',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // total price
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
                                child: BodyMediumMainColorText(
                                  text: AppLocalizations.of(context)!
                                      .order_product_card_total_price,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: BodyMediumMainColorBoldText(
                                  text:
                                      '${CodeNoahPriceConvert.formatPrice(basketProductModel.productTotal)}₺',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
