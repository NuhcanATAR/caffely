// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/feature/products/bloc/cubit.dart';
import 'package:caffely/feature/products/bloc/event.dart';
import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/feature/products/product_detail/productdetail_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/label_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/minselect_button_widget.dart';
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
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
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
                    padding: EdgeInsets.only(
                      right: PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Container(
                        padding: EdgeInsets.all(
                          PaddingSizedsUtility.smallPaddingValue,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(RadiusUtility.circularHighValue),
                          ),
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: IconSizedsUtility.normalSize,
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
            padding: PaddingSizedsUtility.all(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: Column(
              children: <Widget>[
                // body
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      // image
                      SizedBox(
                        width: dynamicViewExtensions.maxWidth(context),
                        height: dynamicViewExtensions.dynamicHeight(
                          context,
                          0.4,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.productModel.coverImg,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  RadiusUtility.lowRadiusValue,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  RadiusUtility.lowRadiusValue,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  RadiusUtility.lowRadiusValue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // title, price, quanity
                      Container(
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.normalPaddingValue,
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
                                    width:
                                        dynamicViewExtensions.maxWidth(context),
                                    child: Padding(
                                      padding: PaddingSizedsUtility.vertical(
                                        PaddingSizedsUtility.smallPaddingValue,
                                      ),
                                      child: TitleLargeBlackBoldText(
                                        text: widget.productModel.title,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  // price
                                  SizedBox(
                                    width:
                                        dynamicViewExtensions.maxWidth(context),
                                    child: Padding(
                                      padding: PaddingSizedsUtility.vertical(
                                        PaddingSizedsUtility.smallPaddingValue,
                                      ),
                                      child: BodyMediumBlackText(
                                        text: '${widget.productModel.price}TL',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // avaible
                      Container(
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.normalPaddingValue,
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
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.normalPaddingValue,
                                ),
                                child: TitleMediumBlackBoldText(
                                  text: AppLocalizations.of(context)!
                                      .products_avaible,
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
                                  coffeType: state.coffeeType ==
                                          ProductCoffeAvaibleTypeControl.hot
                                      ? ProductCoffeAvaibleTypeControl.hot
                                      : ProductCoffeAvaibleTypeControl
                                          .notSelect,
                                  icon: AppIcons.hotOutline,
                                  buttonText: AppLocalizations.of(context)!
                                      .products_hot,
                                ),
                                MinSelectButtonWidget(
                                  func: () {
                                    context.read<ProductBloc>().add(
                                          const ProductAvaibleEvent(
                                            ProductCoffeAvaibleTypeControl.ice,
                                          ),
                                        );
                                  },
                                  coffeType: state.coffeeType ==
                                          ProductCoffeAvaibleTypeControl.ice
                                      ? ProductCoffeAvaibleTypeControl.ice
                                      : ProductCoffeAvaibleTypeControl
                                          .notSelect,
                                  icon: AppIcons.icedOutline,
                                  buttonText: AppLocalizations.of(context)!
                                      .products_ice,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // size
                      Container(
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.normalPaddingValue,
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
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.normalPaddingValue,
                                ),
                                child: TitleMediumBlackBoldText(
                                  text: AppLocalizations.of(context)!
                                      .products_size,
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
                              child: widget.productModel.productType ==
                                      ProductTypeControl.all.productTypeValue
                                  ? ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        MinSelectButtonSecondWidget(
                                          func: () {
                                            context.read<ProductBloc>().add(
                                                  const ProductCoffeSizeEvent(
                                                    ProductTypeControl.small,
                                                  ),
                                                );
                                          },
                                          coffeSize: state.coffeSize ==
                                                  ProductTypeControl.small
                                              ? ProductTypeControl.small
                                              : ProductTypeControl.notSelect,
                                          icon: AppIcons.hotOutline,
                                          buttonText:
                                              AppLocalizations.of(context)!
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
                                          coffeSize: state.coffeSize ==
                                                  ProductTypeControl.middle
                                              ? ProductTypeControl.middle
                                              : ProductTypeControl.notSelect,
                                          icon: AppIcons.hotOutline,
                                          buttonText:
                                              AppLocalizations.of(context)!
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
                                          coffeSize: state.coffeSize ==
                                                  ProductTypeControl.large
                                              ? ProductTypeControl.large
                                              : ProductTypeControl.notSelect,
                                          icon: AppIcons.hotOutline,
                                          buttonText:
                                              AppLocalizations.of(context)!
                                                  .products_size_large,
                                        ),
                                      ],
                                    )
                                  : widget.productModel.productType ==
                                          ProductTypeControl
                                              .small.productTypeValue
                                      ? ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: <Widget>[
                                            MinSelectButtonSecondWidget(
                                              func: () {
                                                context.read<ProductBloc>().add(
                                                      const ProductCoffeSizeEvent(
                                                        ProductTypeControl
                                                            .small,
                                                      ),
                                                    );
                                              },
                                              coffeSize: state.coffeSize ==
                                                      ProductTypeControl.small
                                                  ? ProductTypeControl.small
                                                  : ProductTypeControl
                                                      .notSelect,
                                              icon: AppIcons.hotOutline,
                                              buttonText: AppLocalizations.of(
                                                context,
                                              )!
                                                  .products_size_small,
                                            ),
                                          ],
                                        )
                                      : widget.productModel.productType ==
                                              ProductTypeControl
                                                  .middle.productTypeValue
                                          ? ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                // middle
                                                MinSelectButtonSecondWidget(
                                                  func: () {
                                                    context
                                                        .read<ProductBloc>()
                                                        .add(
                                                          const ProductCoffeSizeEvent(
                                                            ProductTypeControl
                                                                .middle,
                                                          ),
                                                        );
                                                  },
                                                  coffeSize: state.coffeSize ==
                                                          ProductTypeControl
                                                              .middle
                                                      ? ProductTypeControl
                                                          .middle
                                                      : ProductTypeControl
                                                          .notSelect,
                                                  icon: AppIcons.hotOutline,
                                                  buttonText:
                                                      AppLocalizations.of(
                                                    context,
                                                  )!
                                                          .products_size_medium,
                                                ),
                                              ],
                                            )
                                          : widget.productModel.productType ==
                                                  ProductTypeControl
                                                      .large.productTypeValue
                                              ? ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: <Widget>[
                                                    // large
                                                    MinSelectButtonSecondWidget(
                                                      func: () {
                                                        context
                                                            .read<ProductBloc>()
                                                            .add(
                                                              const ProductCoffeSizeEvent(
                                                                ProductTypeControl
                                                                    .large,
                                                              ),
                                                            );
                                                      },
                                                      coffeSize: state
                                                                  .coffeSize ==
                                                              ProductTypeControl
                                                                  .large
                                                          ? ProductTypeControl
                                                              .large
                                                          : ProductTypeControl
                                                              .notSelect,
                                                      icon: AppIcons.hotOutline,
                                                      buttonText: AppLocalizations
                                                              .of(
                                                        context,
                                                      )!
                                                          .products_size_large,
                                                    ),
                                                  ],
                                                )
                                              : widget.productModel
                                                          .productType ==
                                                      ProductTypeControl
                                                          .smallMiddle
                                                  ? ListView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: <Widget>[
                                                        MinSelectButtonSecondWidget(
                                                          func: () {
                                                            context
                                                                .read<
                                                                    ProductBloc>()
                                                                .add(
                                                                  const ProductCoffeSizeEvent(
                                                                    ProductTypeControl
                                                                        .small,
                                                                  ),
                                                                );
                                                          },
                                                          coffeSize: state
                                                                      .coffeSize ==
                                                                  ProductTypeControl
                                                                      .small
                                                              ? ProductTypeControl
                                                                  .small
                                                              : ProductTypeControl
                                                                  .notSelect,
                                                          icon: AppIcons
                                                              .hotOutline,
                                                          buttonText:
                                                              AppLocalizations
                                                                      .of(
                                                            context,
                                                          )!
                                                                  .products_size_small,
                                                        ),
                                                        // middle
                                                        MinSelectButtonSecondWidget(
                                                          func: () {
                                                            context
                                                                .read<
                                                                    ProductBloc>()
                                                                .add(
                                                                  const ProductCoffeSizeEvent(
                                                                    ProductTypeControl
                                                                        .middle,
                                                                  ),
                                                                );
                                                          },
                                                          coffeSize: state
                                                                      .coffeSize ==
                                                                  ProductTypeControl
                                                                      .middle
                                                              ? ProductTypeControl
                                                                  .middle
                                                              : ProductTypeControl
                                                                  .notSelect,
                                                          icon: AppIcons
                                                              .hotOutline,
                                                          buttonText:
                                                              AppLocalizations
                                                                      .of(
                                                            context,
                                                          )!
                                                                  .products_size_medium,
                                                        ),
                                                      ],
                                                    )
                                                  : widget.productModel
                                                              .productType ==
                                                          ProductTypeControl
                                                              .middleLarge
                                                              .productTypeValue
                                                      ? ListView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: <Widget>[
                                                            // middle
                                                            MinSelectButtonSecondWidget(
                                                              func: () {
                                                                context
                                                                    .read<
                                                                        ProductBloc>()
                                                                    .add(
                                                                      const ProductCoffeSizeEvent(
                                                                        ProductTypeControl
                                                                            .middle,
                                                                      ),
                                                                    );
                                                              },
                                                              coffeSize: state
                                                                          .coffeSize ==
                                                                      ProductTypeControl
                                                                          .middle
                                                                  ? ProductTypeControl
                                                                      .middle
                                                                  : ProductTypeControl
                                                                      .notSelect,
                                                              icon: AppIcons
                                                                  .hotOutline,
                                                              buttonText:
                                                                  AppLocalizations
                                                                          .of(
                                                                context,
                                                              )!
                                                                      .products_size_medium,
                                                            ),
                                                            // large
                                                            MinSelectButtonSecondWidget(
                                                              func: () {
                                                                context
                                                                    .read<
                                                                        ProductBloc>()
                                                                    .add(
                                                                      const ProductCoffeSizeEvent(
                                                                        ProductTypeControl
                                                                            .large,
                                                                      ),
                                                                    );
                                                              },
                                                              coffeSize: state
                                                                          .coffeSize ==
                                                                      ProductTypeControl
                                                                          .large
                                                                  ? ProductTypeControl
                                                                      .large
                                                                  : ProductTypeControl
                                                                      .notSelect,
                                                              icon: AppIcons
                                                                  .hotOutline,
                                                              buttonText:
                                                                  AppLocalizations
                                                                          .of(
                                                                context,
                                                              )!
                                                                      .products_size_large,
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      //
                    ],
                  ),
                ),
                // footer
                Row(
                  children: <Widget>[
                    // price
                    Flexible(
                      child: Padding(
                        padding: PaddingSizedsUtility.horizontal(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: Column(
                          children: <Widget>[
                            LabelMediumBlackText(
                              text: AppLocalizations.of(context)!
                                  .products_total_price,
                              textAlign: TextAlign.center,
                            ),
                            TitleMediumBlackBoldText(
                              text:
                                  '${CodeNoahPriceConvert.formatPrice(totalPrice)}₺',
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
                            text: AppLocalizations.of(context)!
                                .products_basket_add_btn,
                            func: () => productBasketAdd(
                              state,
                              totalPrice,
                            ),
                            btnStatus:
                                state.coffeSize == ProductTypeControl.notSelect
                                    ? ButtonTypes.borderPrimaryColorButton
                                    : ButtonTypes.primaryColorButton,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
