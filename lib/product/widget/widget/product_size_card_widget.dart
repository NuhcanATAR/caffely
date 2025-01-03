// ignore_for_file: unrelated_type_equality_checks

import 'package:caffely/feature/products/bloc/cubit.dart';
import 'package:caffely/feature/products/bloc/event.dart';
import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/min_select_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../lang/app_localizations.dart';

class ProductSizeCardWidget extends StatefulWidget {
  const ProductSizeCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.productModel,
    required this.state,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final ProductModel productModel;

  final ProductState state;

  @override
  State<ProductSizeCardWidget> createState() => _ProductSizeCardWidgetState();
}

class _ProductSizeCardWidgetState extends State<ProductSizeCardWidget> {
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
            width: widget.dynamicViewExtensions.maxWidth(context),
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
            width: widget.dynamicViewExtensions.maxWidth(context),
            height: widget.dynamicViewExtensions.dynamicHeight(
              context,
              0.12,
            ),
            child: widget.productModel.productType ==
                    ProductTypeControl.all.productTypeValue
                ? buildAllSizesWidget(context)
                : widget.productModel.productType ==
                        ProductTypeControl.small.productTypeValue
                    ? buildSmallSizesWidget(context)
                    : widget.productModel.productType ==
                            ProductTypeControl.middle.productTypeValue
                        ? buildMiddleSizesWidget(context)
                        : widget.productModel.productType ==
                                ProductTypeControl.large.productTypeValue
                            ? buildLargeSizesWidget(context)
                            : widget.productModel.productType ==
                                    ProductTypeControl.smallMiddle
                                ? buildSmallMiddleSizesWidget(context)
                                : widget.productModel.productType ==
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
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.small,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.small
                ? ProductTypeControl.small
                : ProductTypeControl.notSelect,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(context)!.products_size_small,
          ),
          // middle
          MinSelectButtonSecondWidget(
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.middle,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.middle
                ? ProductTypeControl.middle
                : ProductTypeControl.notSelect,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(context)!.products_size_medium,
          ),
          // large
          MinSelectButtonSecondWidget(
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.large,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.large
                ? ProductTypeControl.large
                : ProductTypeControl.notSelect,
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
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.small,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.small
                ? ProductTypeControl.small
                : ProductTypeControl.notSelect,
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
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.middle,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.middle
                ? ProductTypeControl.middle
                : ProductTypeControl.notSelect,
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
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.large,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.large
                ? ProductTypeControl.large
                : ProductTypeControl.notSelect,
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
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.small,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.small
                ? ProductTypeControl.small
                : ProductTypeControl.notSelect,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_small,
          ),
          // middle
          MinSelectButtonSecondWidget(
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.middle,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.middle
                ? ProductTypeControl.middle
                : ProductTypeControl.notSelect,
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
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.middle,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.middle
                ? ProductTypeControl.middle
                : ProductTypeControl.notSelect,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_medium,
          ),
          // large
          MinSelectButtonSecondWidget(
            func: () {
              context.read<ProductBloc>().add(
                    const ProductCoffeSizeEvent(
                      ProductTypeControl.large,
                    ),
                  );
            },
            coffeSize: widget.state.coffeSize == ProductTypeControl.large
                ? ProductTypeControl.large
                : ProductTypeControl.notSelect,
            icon: AppIcons.hotOutline,
            buttonText: AppLocalizations.of(
              context,
            )!
                .products_size_large,
          ),
        ],
      );
}
