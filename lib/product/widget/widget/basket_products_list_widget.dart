// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/feature/products/product_detail/product_detail_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:flutter/material.dart';

class BasketProductListWidget extends StatelessWidget {
  const BasketProductListWidget({
    super.key,
    required this.product,
    required this.dynamicViewExtensions,
    required this.productModel,
    required this.productRemove,
    required this.produdctQuanityAdd,
    required this.productQuanityReduce,
  });

  final ProductModel product;
  final BasketProductModel productModel;
  final DynamicViewExtensions dynamicViewExtensions;
  final Function() productRemove;
  final Function() produdctQuanityAdd;
  final Function() productQuanityReduce;

  @override
  Widget build(BuildContext context) {
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
                            onTap: productRemove,
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
                    width: dynamicViewExtensions.maxWidth(
                      context,
                    ),
                    child: Padding(
                      padding: BaseUtility.vertical(
                        BaseUtility.paddingSmallValue,
                      ),
                      child: BodyMediumMainColorText(
                        text:
                            '${CodeNoahPriceConvert.formatPrice(productModel.productTotal)}₺',
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
                                  .basket_product_list_size,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: BodyMediumBlackText(
                              text:
                                  ' ${productModel.size == ProductTypeControl.middle.productTypeValue ? 'Orta' : productModel.size == ProductTypeControl.large.productTypeValue ? 'Büyük' : 'Küçük'}',
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
                                  .basket_product_list_avaible,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: BodyMediumBlackText(
                              text:
                                  ' ${productModel.avaible == ProductCoffeAvaibleTypeControl.notSelect.coffeAvaibleTypeValue ? 'Seçim Yok' : productModel.avaible == ProductCoffeAvaibleTypeControl.hot.coffeAvaibleTypeValue ? 'Sıcak' : productModel.avaible == ProductCoffeAvaibleTypeControl.ice.coffeAvaibleTypeValue ? 'Soğuk' : 'Bilinmiyor'}',
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
                          onTap: produdctQuanityAdd,
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
                            text: productModel.quanity.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // reduce
                        GestureDetector(
                          onTap: productQuanityReduce,
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
}
