import 'package:caffely/feature/products/bloc/cubit.dart';
import 'package:caffely/feature/products/bloc/event.dart';
import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/min_select_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/icon.dart';
import '../../util/base_utility.dart';

class ProductAvaibleCardWidget extends StatefulWidget {
  const ProductAvaibleCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.state,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final ProductState state;

  @override
  State<ProductAvaibleCardWidget> createState() =>
      _ProductAvaibleCardWidgetState();
}

class _ProductAvaibleCardWidgetState extends State<ProductAvaibleCardWidget> {
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
                text: AppLocalizations.of(context)!.products_avaible,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // avaible
          Row(
            children: <Widget>[
              MinSelectButtonWidget(
                func: () {
                  context.read<ProductBloc>().add(
                        const ProductAvaibleEvent(
                          ProductCoffeAvaibleTypeControl.hot,
                        ),
                      );
                },
                coffeType: widget.state.coffeeType ==
                        ProductCoffeAvaibleTypeControl.hot
                    ? ProductCoffeAvaibleTypeControl.hot
                    : ProductCoffeAvaibleTypeControl.notSelect,
                icon: AppIcons.hotOutline,
                buttonText: AppLocalizations.of(context)!.products_hot,
              ),
              MinSelectButtonWidget(
                func: () {
                  context.read<ProductBloc>().add(
                        const ProductAvaibleEvent(
                          ProductCoffeAvaibleTypeControl.ice,
                        ),
                      );
                },
                coffeType: widget.state.coffeeType ==
                        ProductCoffeAvaibleTypeControl.ice
                    ? ProductCoffeAvaibleTypeControl.ice
                    : ProductCoffeAvaibleTypeControl.notSelect,
                icon: AppIcons.icedOutline,
                buttonText: AppLocalizations.of(context)!.products_ice,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
