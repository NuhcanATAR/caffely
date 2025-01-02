// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:caffely/feature/products/bloc/cubit.dart';
import 'package:caffely/feature/products/bloc/event.dart';
import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/feature/products/product_detail/product_detail_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/label_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/product_avaible_card_widget.dart';
import 'package:caffely/product/widget/widget/product_image_card_widget.dart';
import 'package:caffely/product/widget/widget/product_information_card_widget.dart';
import 'package:caffely/product/widget/widget/product_size_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends ProductDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AppIcons.closeOutline.toSvgImg(
            Colors.black,
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: getFavoriteStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const SizedBox();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }

              if (snapshot.hasData) {
                final favorites = snapshot.data!.docs;
                final isFavorite = favorites
                    .any((doc) => doc['product_id'] == widget.productModel.id);

                return GestureDetector(
                  onTap: () {
                    context.read<ProductBloc>().add(
                          ProductFavoriteCreateEvent(
                            widget.productModel.id,
                            isFavorite
                                ? favorites.firstWhere(
                                    (doc) =>
                                        doc['product_id'] ==
                                        widget.productModel.id,
                                  )['id']
                                : '',
                            !isFavorite,
                            context,
                          ),
                        );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: BaseUtility.paddingNormalValue,
                    ),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Container(
                        padding: const EdgeInsets.all(
                          BaseUtility.paddingSmallValue,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              BaseUtility.radiusCircularHighValue,
                            ),
                          ),
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: BaseUtility.iconNormalSize,
                        ),
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          late final int totalPrice = (widget.productModel.price * 1) +
              (state.coffeSize == ProductTypeControl.middle
                  ? widget.productModel.middlePrice
                  : state.coffeSize == ProductTypeControl.large
                      ? widget.productModel.largePrice
                      : 0);
          return Padding(
            padding: BaseUtility.all(
              BaseUtility.paddingNormalValue,
            ),
            child: Column(
              children: <Widget>[
                // body
                buildBodyWidget(state),
                // footer
                buildFooterWidget(totalPrice, state),
              ],
            ),
          );
        },
      ),
    );
  }

  // body
  Widget buildBodyWidget(ProductState state) => Expanded(
        child: ListView(
          children: <Widget>[
            // image
            ProductImageCardWidget(
              dynamicViewExtensions: dynamicViewExtensions,
              productModel: widget.productModel,
            ),
            // title, price, quanity
            ProductInformationCardWidget(
              dynamicViewExtensions: dynamicViewExtensions,
              productModel: widget.productModel,
            ),
            // avaible
            Container(
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
                        text: AppLocalizations.of(context)!.products_avaible,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  // avaible
                  ProductAvaibleCardWidget(
                    dynamicViewExtensions: dynamicViewExtensions,
                    state: state,
                  ),
                ],
              ),
            ),
            // size
            ProductSizeCardWidget(
              state: state,
              dynamicViewExtensions: dynamicViewExtensions,
              productModel: widget.productModel,
            ),

            //
          ],
        ),
      );

  // footer
  Widget buildFooterWidget(
    int totalPrice,
    ProductState state,
  ) =>
      Row(
        children: <Widget>[
          // price
          Flexible(
            child: Padding(
              padding: BaseUtility.horizontal(
                BaseUtility.paddingNormalValue,
              ),
              child: Column(
                children: <Widget>[
                  LabelMediumBlackText(
                    text: AppLocalizations.of(context)!.products_total_price,
                    textAlign: TextAlign.center,
                  ),
                  TitleMediumBlackBoldText(
                    text: '${CodeNoahPriceConvert.formatPrice(totalPrice)}₺',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // basket add
          Expanded(
            flex: 3,
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: basketAddListenerBloc,
              builder: (BuildContext context, blocConsumertate) {
                return CustomButtonWidget(
                  dynamicViewExtensions: dynamicViewExtensions,
                  text: AppLocalizations.of(context)!.products_basket_add_btn,
                  func: () => productBasketAdd(
                    state,
                    totalPrice,
                  ),
                  btnStatus: state.coffeSize == ProductTypeControl.notSelect
                      ? ButtonTypes.borderPrimaryColorButton
                      : ButtonTypes.primaryColorButton,
                );
              },
            ),
          ),
        ],
      );
}
