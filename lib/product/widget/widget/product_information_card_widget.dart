import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:flutter/material.dart';

class ProductInformationCardWidget extends StatelessWidget {
  const ProductInformationCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.productModel,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final ProductModel productModel;

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
      child: Row(
        children: <Widget>[
          // title and price
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Column(
              children: <Widget>[
                // title
                SizedBox(
                  width: dynamicViewExtensions.maxWidth(context),
                  child: Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingSmallValue,
                    ),
                    child: TitleLargeBlackBoldText(
                      text: productModel.title,
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
                    child: BodyMediumBlackText(
                      text: '${productModel.price}TL',
                      textAlign: TextAlign.left,
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
}
