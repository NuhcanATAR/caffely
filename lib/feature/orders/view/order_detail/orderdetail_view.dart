// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/feature/orders/bloc/cubit.dart';
import 'package:caffely/feature/orders/bloc/state.dart';
import 'package:caffely/feature/orders/view/order_detail/orderdetail_viewmodel.dart';
import 'package:caffely/feature/products/product_detail/productdetail_view.dart';
import 'package:caffely/feature/store/view/store_detail/storedetail_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/orderbasket_control.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/model/basket_model/basket_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/order_model/order_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends OrderDetailViewModel {
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
          text: 'Sipariş Detayı',
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseCollectionReferances.orders.collectRef
                  .doc(widget.orderModel.id)
                  .collection(FirebaseCollectionReferances.basket.name)
                  .doc(widget.orderModel.id)
                  .get(),
              builder: (
                BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return const CustomResponseWidget(
                    img: AppImages.error,
                    title: 'Sipariş Detayı Bulunamadı',
                    subTitle:
                        'Sipariş bilgileri yüklenirken bir sorun oluştu, lütfen daha sonra tekrar deneyiniz.',
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  final basketData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final BasketModel basketModel =
                      BasketModel.fromJson(basketData);
                  return Padding(
                    padding: PaddingSizedsUtility.all(
                      PaddingSizedsUtility.mediumPaddingValue,
                    ),
                    child: ListView(
                      children: <Widget>[
                        // order status
                        buildOrderStatusCardWidget(basketModel),
                        // adress
                        buildOrderAdressCardWidget,
                        // stores and products
                        buildStoresAndProductsCardWidget(state),
                        // payment details
                        buildPaymentDetailsCardWidget(state),
                      ],
                    ),
                  );
                }

                return const CustomResponseWidget(
                  img: AppImages.error,
                  title: 'Sipariş Detayı Bulunamadı',
                  subTitle:
                      'Sipariş bilgileri yüklenirken bir sorun oluştu, lütfen daha sonra tekrar deneyiniz.',
                );
              },
            );
          } else {
            return const CustomResponseWidget(
              img: AppImages.error,
              title: 'Sipariş Detayı Bulunamadı',
              subTitle:
                  'Sipariş bilgileri yüklenirken bir sorun oluştu, lütfen daha sonra tekrar deneyiniz.',
            );
          }
        },
      ),
    );
  }

  // order status
  Widget buildOrderStatusCardWidget(BasketModel basketModel) => Padding(
        padding: PaddingSizedsUtility.vertical(
          PaddingSizedsUtility.mediumPaddingValue,
        ),
        child: Row(
          children: <Widget>[
            // order received
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Padding(
                padding: PaddingSizedsUtility.all(
                  PaddingSizedsUtility.mediumPaddingValue,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: PaddingSizedsUtility.all(
                        PaddingSizedsUtility.mediumPaddingValue,
                      ),
                      decoration: BoxDecoration(
                        color: basketModel.basketStatus >=
                                BasketMainStatusControl.orderReceived.value
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(
                          RadiusUtility.circularHighValue,
                        ),
                      ),
                      child: AppIcons.boxBold.toSvgImg(
                        Colors.white,
                        IconSizedsUtility.normalSize,
                        IconSizedsUtility.normalSize,
                      ),
                    ),
                    Padding(
                      padding: PaddingSizedsUtility.vertical(
                        PaddingSizedsUtility.mediumPaddingValue,
                      ),
                      child: const BodyMediumBlackBoldText(
                        text: 'Onaylandı',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 3,
                    color: basketModel.basketStatus >=
                            BasketMainStatusControl.orderReceived.value
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                ],
              ),
            ),
            // order in progress
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Padding(
                padding: PaddingSizedsUtility.all(
                  PaddingSizedsUtility.mediumPaddingValue,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: PaddingSizedsUtility.all(
                        PaddingSizedsUtility.mediumPaddingValue,
                      ),
                      decoration: BoxDecoration(
                        color: basketModel.basketStatus >=
                                BasketMainStatusControl.orderInProgress.value
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(
                          RadiusUtility.circularHighValue,
                        ),
                      ),
                      child: AppIcons.boxBold.toSvgImg(
                        Colors.white,
                        IconSizedsUtility.normalSize,
                        IconSizedsUtility.normalSize,
                      ),
                    ),
                    Padding(
                      padding: PaddingSizedsUtility.vertical(
                        PaddingSizedsUtility.mediumPaddingValue,
                      ),
                      child: const BodyMediumBlackBoldText(
                        text: 'Hazırlanıyor',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 3,
                    color: basketModel.basketStatus >=
                            BasketMainStatusControl.orderInProgress.value
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                ],
              ),
            ),
            // order delivered
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Padding(
                padding: PaddingSizedsUtility.all(
                  PaddingSizedsUtility.mediumPaddingValue,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: PaddingSizedsUtility.all(
                        PaddingSizedsUtility.mediumPaddingValue,
                      ),
                      decoration: BoxDecoration(
                        color: basketModel.basketStatus >=
                                BasketMainStatusControl.orderDelivered.value
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(
                          RadiusUtility.circularHighValue,
                        ),
                      ),
                      child: AppIcons.boxBold.toSvgImg(
                        Colors.white,
                        IconSizedsUtility.normalSize,
                        IconSizedsUtility.normalSize,
                      ),
                    ),
                    Padding(
                      padding: PaddingSizedsUtility.vertical(
                        PaddingSizedsUtility.mediumPaddingValue,
                      ),
                      child: const BodyMediumBlackBoldText(
                        text: 'Teslim Edildi',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  // adress
  Widget get buildOrderAdressCardWidget => SizedBox(
        width: dynamicViewExtensions.maxWidth(context),
        child: Container(
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.normalPaddingValue,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(
              RadiusUtility.normalRadiusValue,
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: PaddingSizedsUtility.top(
                  PaddingSizedsUtility.mediumPaddingValue,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: MarginSizedsUtility.right(
                        MarginSizedsUtility.normalMarginValue,
                      ),
                      padding: PaddingSizedsUtility.all(
                        PaddingSizedsUtility.mediumPaddingValue,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.outline.withAlpha(15),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(
                          RadiusUtility.circularHighValue,
                        ),
                      ),
                      child: AppIcons.locationOutline.toSvgImg(
                        Colors.black,
                        IconSizedsUtility.normalSize,
                        IconSizedsUtility.normalSize,
                      ),
                    ),
                  ],
                ),
              ),
              // adress information
              Expanded(
                child: Padding(
                  padding: PaddingSizedsUtility.horizontal(
                    PaddingSizedsUtility.mediumPaddingValue,
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
                            text: widget.orderModel.adressTitle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      // explanation
                      SizedBox(
                        width: dynamicViewExtensions.maxWidth(context),
                        child: Padding(
                          padding: PaddingSizedsUtility.bottom(
                            PaddingSizedsUtility.mediumPaddingValue,
                          ),
                          child: BodyMediumBlackText(
                            text: widget.orderModel.adressDirections,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      // city / district
                      SizedBox(
                        width: dynamicViewExtensions.maxWidth(context),
                        child: Padding(
                          padding: PaddingSizedsUtility.bottom(
                            PaddingSizedsUtility.mediumPaddingValue,
                          ),
                          child: Row(
                            children: <Widget>[
                              AppIcons.locationFill.toSvgImg(
                                Colors.grey,
                                IconSizedsUtility.mediumSize,
                                IconSizedsUtility.mediumSize,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: PaddingSizedsUtility.left(
                                    PaddingSizedsUtility.mediumPaddingValue,
                                  ),
                                  child: BodyMediumBlackText(
                                    text:
                                        '${widget.orderModel.adressCity} / ${widget.orderModel.adressDistrict}',
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
            ],
          ),
        ),
      );

  // stores and products
  Widget buildStoresAndProductsCardWidget(OrderLoaded state) => SizedBox(
        width: dynamicViewExtensions.maxWidth(context),
        child: Container(
          margin:
              MarginSizedsUtility.top(MarginSizedsUtility.normalMarginValue),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                RadiusUtility.normalRadiusValue,
              ),
            ),
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.branches.length,
            itemBuilder: (context, index) {
              final storeModel = state.branches[index];

              return Container(
                margin: MarginSizedsUtility.vertical(
                  MarginSizedsUtility.mediumMarginValue,
                ),
                padding: PaddingSizedsUtility.all(
                  PaddingSizedsUtility.mediumPaddingValue,
                ),
                decoration: state.branches.length > 1
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 0.5,
                          ),
                        ),
                      )
                    : const BoxDecoration(),
                child: Column(
                  children: <Widget>[
                    // store information
                    SizedBox(
                      width: dynamicViewExtensions.maxWidth(context),
                      child: Padding(
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.mediumPaddingValue,
                        ),
                        child: Row(
                          children: <Widget>[
                            // branch logo
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: Container(
                                padding: PaddingSizedsUtility.all(
                                  PaddingSizedsUtility.smallPaddingValue,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      RadiusUtility.circularHighValue,
                                    ),
                                  ),
                                ),
                                child: AppLogoConstants
                                    .appLogoNoBackgroundColorPrimary.toImg,
                              ),
                            ),
                            // branch information
                            Expanded(
                              child: FutureBuilder<DocumentSnapshot>(
                                future: FirebaseCollectionReferances
                                    .stores.collectRef
                                    .doc(storeModel.id)
                                    .get(),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot,
                                ) {
                                  if (snapshot.hasError) {
                                    return const SizedBox();
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  }

                                  if (snapshot.hasData) {
                                    final Map<String, dynamic> storeData =
                                        snapshot.data!.data()
                                            as Map<String, dynamic>;

                                    final StoreModel storeModel =
                                        StoreModel.fromJson(
                                      storeData,
                                    );

                                    return GestureDetector(
                                      onTap: () {
                                        CodeNoahNavigatorRouter.push(
                                          context,
                                          StoreDetailView(
                                            storeModel: storeModel,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            PaddingSizedsUtility.horizontal(
                                          PaddingSizedsUtility
                                              .normalPaddingValue,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            // store title
                                            SizedBox(
                                              width: dynamicViewExtensions
                                                  .maxWidth(
                                                context,
                                              ),
                                              child: Padding(
                                                padding: PaddingSizedsUtility
                                                    .vertical(
                                                  PaddingSizedsUtility
                                                      .smallPaddingValue,
                                                ),
                                                child: BodyMediumBlackBoldText(
                                                  text: storeModel.storeName,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            // store location
                                            SizedBox(
                                              width: dynamicViewExtensions
                                                  .maxWidth(
                                                context,
                                              ),
                                              child: Padding(
                                                padding:
                                                    PaddingSizedsUtility.bottom(
                                                  PaddingSizedsUtility
                                                      .smallPaddingValue,
                                                ),
                                                child: BodyMediumBlackText(
                                                  text:
                                                      '${storeModel.locationCity}/${storeModel.locationDistrict}',
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // products
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseCollectionReferances.orders.collectRef
                          .doc(widget.orderModel.id)
                          .collection(
                            FirebaseCollectionReferances.basket.name,
                          )
                          .doc(widget.orderModel.id)
                          .collection(
                            FirebaseCollectionReferances.branch.name,
                          )
                          .doc(storeModel.id)
                          .collection(
                            FirebaseCollectionReferances.product.name,
                          )
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const SizedBox();
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }

                        if (snapshot.hasData) {
                          final List<BasketProductModel> productList =
                              snapshot.data!.docs.map((doc) {
                            return BasketProductModel.fromJson(
                              doc.data() as Map<String, dynamic>,
                            );
                          }).toList();
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              final basketProductModel = productList[index];

                              return FutureBuilder<DocumentSnapshot>(
                                future: FirebaseCollectionReferances
                                    .product.collectRef
                                    .doc(basketProductModel.productId)
                                    .get(),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot,
                                ) {
                                  if (snapshot.hasError) {
                                    return const SizedBox();
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  }

                                  if (snapshot.hasData) {
                                    final productMap = snapshot.data!.data()
                                        as Map<String, dynamic>;
                                    final ProductModel productModel =
                                        ProductModel.fromJson(productMap);

                                    return Padding(
                                      padding: PaddingSizedsUtility.top(
                                        PaddingSizedsUtility.normalPaddingValue,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          CodeNoahNavigatorRouter.push(
                                            context,
                                            ProductDetailView(
                                              productModel: productModel,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: PaddingSizedsUtility.all(
                                            PaddingSizedsUtility
                                                .smallPaddingValue,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                RadiusUtility
                                                    .circularMediumValue,
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
                                                  height: dynamicViewExtensions
                                                      .dynamicHeight(
                                                    context,
                                                    0.11,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: productModel
                                                        .coverImg
                                                        .toString(),
                                                    imageBuilder: (
                                                      context,
                                                      imageProvider,
                                                    ) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            RadiusUtility
                                                                .circularMediumValue,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            RadiusUtility
                                                                .circularMediumValue,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            RadiusUtility
                                                                .circularMediumValue,
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
                                                  padding: PaddingSizedsUtility
                                                      .horizontal(
                                                    PaddingSizedsUtility
                                                        .normalPaddingValue,
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      // title
                                                      SizedBox(
                                                        width:
                                                            dynamicViewExtensions
                                                                .maxWidth(
                                                          context,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              PaddingSizedsUtility
                                                                  .vertical(
                                                            PaddingSizedsUtility
                                                                .smallPaddingValue,
                                                          ),
                                                          child:
                                                              TitleMediumBlackBoldText(
                                                            text: productModel
                                                                .title,
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ),
                                                      // quanity
                                                      SizedBox(
                                                        width:
                                                            dynamicViewExtensions
                                                                .maxWidth(
                                                          context,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              PaddingSizedsUtility
                                                                  .vertical(
                                                            PaddingSizedsUtility
                                                                .smallPaddingValue,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                child:
                                                                    BodyMediumBlackText(
                                                                  text: 'Adet',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                fit: FlexFit
                                                                    .tight,
                                                                flex: 1,
                                                                child:
                                                                    BodyMediumBlackText(
                                                                  text:
                                                                      'Adet ${basketProductModel.quanity}x',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // size
                                                      SizedBox(
                                                        width:
                                                            dynamicViewExtensions
                                                                .maxWidth(
                                                          context,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              PaddingSizedsUtility
                                                                  .vertical(
                                                            PaddingSizedsUtility
                                                                .smallPaddingValue,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                child:
                                                                    BodyMediumBlackText(
                                                                  text: 'Boyut',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                fit: FlexFit
                                                                    .tight,
                                                                flex: 1,
                                                                child:
                                                                    BodyMediumBlackText(
                                                                  text:
                                                                      ' ${basketProductModel.size == ProductTypeControl.middle.productTypeValue ? 'Orta' : basketProductModel.size == ProductTypeControl.large.productTypeValue ? 'Büyük' : 'Küçük'}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // avaible
                                                      SizedBox(
                                                        width:
                                                            dynamicViewExtensions
                                                                .maxWidth(
                                                          context,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              PaddingSizedsUtility
                                                                  .vertical(
                                                            PaddingSizedsUtility
                                                                .smallPaddingValue,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                child:
                                                                    BodyMediumBlackText(
                                                                  text: 'Boyut',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                fit: FlexFit
                                                                    .tight,
                                                                flex: 1,
                                                                child:
                                                                    BodyMediumBlackText(
                                                                  text:
                                                                      ' ${basketProductModel.avaible == ProductCoffeAvaibleTypeControl.notSelect.coffeAvaibleTypeValue ? 'Seçim Yok' : basketProductModel.avaible == ProductCoffeAvaibleTypeControl.hot.coffeAvaibleTypeValue ? 'Sıcak' : basketProductModel.avaible == ProductCoffeAvaibleTypeControl.ice.coffeAvaibleTypeValue ? 'Soğuk' : 'Bilinmiyor'}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // price
                                                      SizedBox(
                                                        width:
                                                            dynamicViewExtensions
                                                                .maxWidth(
                                                          context,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              PaddingSizedsUtility
                                                                  .vertical(
                                                            PaddingSizedsUtility
                                                                .smallPaddingValue,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                child:
                                                                    BodyMediumMainColorText(
                                                                  text: 'Fiyat',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                fit: FlexFit
                                                                    .tight,
                                                                flex: 1,
                                                                child:
                                                                    BodyMediumMainColorBoldText(
                                                                  text:
                                                                      '${CodeNoahPriceConvert.formatPrice(
                                                                    basketProductModel.size ==
                                                                            ProductTypeControl
                                                                                .middle.productTypeValue
                                                                        ? productModel.price +
                                                                            productModel
                                                                                .middlePrice
                                                                        : basketProductModel.size ==
                                                                                ProductTypeControl.large.productTypeValue
                                                                            ? productModel.price + productModel.largePrice
                                                                            : productModel.price,
                                                                  )}₺',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      // total price
                                                      SizedBox(
                                                        width:
                                                            dynamicViewExtensions
                                                                .maxWidth(
                                                          context,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              PaddingSizedsUtility
                                                                  .vertical(
                                                            PaddingSizedsUtility
                                                                .smallPaddingValue,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              const Expanded(
                                                                child:
                                                                    BodyMediumMainColorText(
                                                                  text:
                                                                      'Toplam Fiyat',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                fit: FlexFit
                                                                    .tight,
                                                                flex: 1,
                                                                child:
                                                                    BodyMediumMainColorBoldText(
                                                                  text:
                                                                      '${CodeNoahPriceConvert.formatPrice(basketProductModel.productTotal)}₺',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              );
                            },
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

  // payment details
  Widget buildPaymentDetailsCardWidget(OrderLoaded state) => SizedBox(
        width: dynamicViewExtensions.maxWidth(context),
        child: Container(
          margin: MarginSizedsUtility.top(
            MarginSizedsUtility.normalMarginValue,
          ),
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.normalPaddingValue,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(
              RadiusUtility.normalRadiusValue,
            ),
          ),
          child: Column(
            children: <Widget>[
              // title
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Container(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: const TitleMediumBlackBoldText(
                    text: 'Ödeme Detayları',
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              // payment details
              // payment type
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: BodyMediumBlackText(
                          text: 'Ödeme Tipi',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: BodyMediumBlackBoldText(
                          text: widget.orderModel.paymentType ==
                                  OrderPaymentType.online.value
                              ? 'Online Ödeme'
                              : 'Kapıda Ödeme',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // total price
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: BodyMediumBlackText(
                          text: 'Toplam Fiyat',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: BodyMediumBlackBoldText(
                          text:
                              '${CodeNoahPriceConvert.formatPrice(state.totalPrice)}₺',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // quanity
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: BodyMediumBlackText(
                          text: 'Adet',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: BodyMediumBlackBoldText(
                          text: '${state.totalQuanity}x',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // service free
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: const Row(
                    children: <Widget>[
                      Expanded(
                        child: BodyMediumBlackText(
                          text: 'Servis Ücreti',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: BodyMediumBlackBoldText(
                          text: '0₺',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // delivery free
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: const Row(
                    children: <Widget>[
                      Expanded(
                        child: BodyMediumBlackText(
                          text: 'Teslimat Ücreti',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: BodyMediumBlackBoldText(
                          text: '0₺',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // totalp paymet
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: BodyMediumBlackText(
                          text: 'Toplam Ödeme',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: BodyMediumBlackBoldText(
                          text:
                              '${CodeNoahPriceConvert.formatPrice(state.totalPrice)}₺',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
