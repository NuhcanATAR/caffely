// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
    required this.dynamicViewExtensions,
    required this.func,
    required this.isCardStatus,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final ProductModel product;
  final Function() func;
  final ProductCardType isCardStatus;

  @override
  Widget build(BuildContext context) {
    return isCardStatus.cardTypeValue ==
            ProductCardType.horizontal.cardTypeValue
        ? Padding(
            padding: BaseUtility.right(
              BaseUtility.paddingNormalValue,
            ),
            child: GestureDetector(
              onTap: func,
              child: SizedBox(
                width: dynamicViewExtensions.dynamicWidth(
                  context,
                  0.4,
                ),
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
                  child: Column(
                    children: <Widget>[
                      // top
                      Expanded(
                        flex: 4,
                        child: CachedNetworkImage(
                          imageUrl: product.coverImg.toString(),
                          imageBuilder: (
                            context,
                            imageProvider,
                          ) {
                            return Container(
                              padding: BaseUtility.all(
                                BaseUtility.paddingSmallValue,
                              ),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                            );
                          },
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                                topRight: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                                topRight: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // body
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // title
                                SizedBox(
                                  width: dynamicViewExtensions.maxWidth(
                                    context,
                                  ),
                                  child: Padding(
                                    padding: BaseUtility.all(
                                      BaseUtility.paddingMediumValue,
                                    ),
                                    child: BodyMediumBlackBoldText(
                                      text: product.title,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                // location
                                SizedBox(
                                  width: dynamicViewExtensions.maxWidth(
                                    context,
                                  ),
                                  child: Padding(
                                    padding: BaseUtility.horizontal(
                                      BaseUtility.paddingMediumValue,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        AppIcons.locationFill.toSvgImg(
                                          Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          BaseUtility.iconMediumSize,
                                          BaseUtility.iconMediumSize,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: BaseUtility.left(
                                              BaseUtility.paddingSmallValue,
                                            ),
                                            child: BodyMediumMainColorText(
                                              text: '${product.price}₺',
                                              textAlign: TextAlign.left,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: BaseUtility.top(
              BaseUtility.paddingNormalValue,
            ),
            child: GestureDetector(
              onTap: func,
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
                        height:
                            dynamicViewExtensions.dynamicHeight(context, 0.14),
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
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: BaseUtility.vertical(
                                  BaseUtility.paddingSmallValue,
                                ),
                                child: TitleMediumBlackBoldText(
                                  text: product.title,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            // price
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: BaseUtility.vertical(
                                  BaseUtility.paddingSmallValue,
                                ),
                                child: BodyMediumMainColorText(
                                  text:
                                      '${CodeNoahPriceConvert.formatPrice(product.price)}₺',
                                  textAlign: TextAlign.left,
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
