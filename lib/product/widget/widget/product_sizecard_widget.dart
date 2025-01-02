// ignore_for_file: unrelated_type_equality_checks

import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/minselect_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../lang/app_localizations.dart';

class ProductSizeCardWidget extends StatelessWidget {
  const ProductSizeCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.productModel,
    required this.smallFunc,
    required this.middleFunc,
    required this.largeFunc,
    required this.smallCoffeSize,
    required this.middleCoffeSize,
    required this.largeCoffeSize,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final ProductModel productModel;
  final Function() smallFunc;
  final Function() middleFunc;
  final Function() largeFunc;
  final ProductTypeControl smallCoffeSize;
  final ProductTypeControl middleCoffeSize;
  final ProductTypeControl largeCoffeSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: BaseUtility.vertical(
        BaseUtility.paddingNormalValue,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
      ),
      child: Column(
        children: <Widget>[
          // title
          SizedBox(
            width: dynamicViewExtensions.maxWidth(context),
            child: Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingNormalValue,
              ),
              child: TitleMediumBlackBoldText(
                text: AppLocalizations.of(context)!.products_size,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // avaible
          SizedBox(
            width: dynamicViewExtensions.maxWidth(context),
            height: dynamicViewExtensions.dynamicHeight(
              context,
              0.12,
            ),
            child: productModel.productType ==
                    ProductTypeControl.all.productTypeValue
                ? buildAllSizesWidget(context)
                : productModel.productType ==
                        ProductTypeControl.small.productTypeValue
                    ? buildSmallSizesWidget(context)
                    : productModel.productType ==
                            ProductTypeControl.middle.productTypeValue
                        ? buildMiddleSizesWidget(context)
                        : productModel.productType ==
                                ProductTypeControl.large.productTypeValue
                            ? buildLargeSizesWidget(context)
                            : productModel.productType ==
                                    ProductTypeControl.smallMiddle
                                ? buildSmallMiddleSizesWidget(context)
                                : productModel.productType ==
                                        ProductTypeControl
                                            .middleLarge.productTypeValue
                                    ? buildMiddleLargeSizesWidget(context)
                                    : const SizedBox(),
          ),
        ],
      ),
    );
  }

  // all sizes
  Widget buildAllSizesWidget(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // small
          MinSelectButtonSecondWidget(
            func: smallFunc,
            coffeSize: smallCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(context)!.products_size_small,
          ),
          // middle
          MinSelectButtonSecondWidget(
            func: middleFunc,
            coffeSize: middleCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(context)!.products_size_medium,
          ),
          // large
          MinSelectButtonSecondWidget(
            func: largeFunc,
            coffeSize: largeCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(context)!.products_size_large,
          ),
        ],
      );

  // small sizes
  Widget buildSmallSizesWidget(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // small
          MinSelectButtonSecondWidget(
            func: smallFunc,
            coffeSize: smallCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_small,
          ),
        ],
      );

  // middle sizes
  Widget buildMiddleSizesWidget(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // middle
          MinSelectButtonSecondWidget(
            func: middleFunc,
            coffeSize: middleCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_medium,
          ),
        ],
      );

  // large sizes
  Widget buildLargeSizesWidget(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // large
          MinSelectButtonSecondWidget(
            func: largeFunc,
            coffeSize: largeCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_large,
          ),
        ],
      );

  // small middle sizes
  Widget buildSmallMiddleSizesWidget(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // small
          MinSelectButtonSecondWidget(
            func: smallFunc,
            coffeSize: smallCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_small,
          ),
          // middle
          MinSelectButtonSecondWidget(
            func: middleFunc,
            coffeSize: middleCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_medium,
          ),
        ],
      );

  // middle large sizes
  Widget buildMiddleLargeSizesWidget(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // middle
          MinSelectButtonSecondWidget(
            func: middleFunc,
            coffeSize: middleCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_medium,
          ),
          // large
          MinSelectButtonSecondWidget(
            func: largeFunc,
            coffeSize: largeCoffeSize,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_large,
          ),
        ],
      );
}
