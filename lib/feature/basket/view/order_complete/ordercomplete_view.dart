import 'package:caffely/feature/basket/view/order_complete/ordercomplete_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';

class OrderCompleteView extends StatefulWidget {
  const OrderCompleteView({
    super.key,
    required this.branches,
    required this.basketProducts,
  });

  final List<BasketBranchModel> branches;
  final List<BasketProductModel> basketProducts;

  @override
  State<OrderCompleteView> createState() => _OrderCompleteViewState();
}

class _OrderCompleteViewState extends OrderCompleteViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: AppIcons.arrowLeft.toSvgImg(
            Colors.black,
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Siparişi Tamamla',
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: Column(
          children: <Widget>[
            // body
            Expanded(
              child: ListView(
                children: const <Widget>[],
              ),
            ),
            // footer button
            CustomButtonWidget(
              dynamicViewExtensions: dynamicViewExtensions,
              text: 'Siparişi Oluştur',
              func: () {},
              btnStatus: ButtonTypes.primaryColorButton,
            ),
          ],
        ),
      ),
    );
  }
}
