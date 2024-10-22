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
            padding: PaddingSizedsUtility.right(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: GestureDetector(
              onTap: func,
              child: SizedBox(
                width: dynamicViewExtensions.dynamicWidth(
                  context,
                  0.4,
                ),
                child: Container(
                  padding: PaddingSizedsUtility.all(
                    PaddingSizedsUtility.smallPaddingValue,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        RadiusUtility.circularMediumValue,
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
                              padding: PaddingSizedsUtility.all(
                                PaddingSizedsUtility.smallPaddingValue,
                              ),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    RadiusUtility.circularMediumValue,
                                  ),
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  RadiusUtility.circularMediumValue,
                                ),
                                topRight: Radius.circular(
                                  RadiusUtility.circularMediumValue,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  RadiusUtility.circularMediumValue,
                                ),
                                topRight: Radius.circular(
                                  RadiusUtility.circularMediumValue,
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
                                    padding: PaddingSizedsUtility.all(
                                      PaddingSizedsUtility.mediumPaddingValue,
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
                                    padding: PaddingSizedsUtility.horizontal(
                                      PaddingSizedsUtility.mediumPaddingValue,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        AppIcons.locationFill.toSvgImg(
                                          Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          IconSizedsUtility.mediumSize,
                                          IconSizedsUtility.mediumSize,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: PaddingSizedsUtility.left(
                                              PaddingSizedsUtility
                                                  .smallPaddingValue,
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
            padding: PaddingSizedsUtility.top(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: GestureDetector(
              onTap: func,
              child: Container(
                padding: PaddingSizedsUtility.all(
                  PaddingSizedsUtility.smallPaddingValue,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      RadiusUtility.circularMediumValue,
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  RadiusUtility.circularMediumValue,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  RadiusUtility.circularMediumValue,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  RadiusUtility.circularMediumValue,
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
                        padding: PaddingSizedsUtility.horizontal(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: Column(
                          children: <Widget>[
                            // title
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.smallPaddingValue,
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
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.smallPaddingValue,
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
