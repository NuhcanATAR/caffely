// ignore_for_file: deprecated_member_use

import 'package:caffely/feature/orders/bloc/cubit.dart';
import 'package:caffely/feature/orders/bloc/state.dart';
import 'package:caffely/feature/orders/view/order_detail/orderdetail_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/model/basket_model/basket_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/order_model/order_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/order_adresscard_widget.dart';
import 'package:caffely/product/widget/widget/order_paymentdetails_card_widget.dart';
import 'package:caffely/product/widget/widget/order_productcard_widget.dart';
import 'package:caffely/product/widget/widget/order_statuscard_widget.dart';
import 'package:caffely/product/widget/widget/order_storecard_widget.dart';
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
  Widget buildOrderStatusCardWidget(BasketModel basketModel) =>
      OrderStatusCardWidget(
        basketModel: basketModel,
      );

  // adress
  Widget get buildOrderAdressCardWidget => OrderAdressCardWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        orderModel: widget.orderModel,
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
                    OrderStoreCardWidget(
                      dynamicViewExtensions: dynamicViewExtensions,
                      storeModel: storeModel,
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

                                    return OrderProductCardWidget(
                                      productModel: productModel,
                                      dynamicViewExtensions:
                                          dynamicViewExtensions,
                                      basketProductModel: basketProductModel,
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
  Widget buildPaymentDetailsCardWidget(OrderLoaded state) =>
      OrderpaymentDetailsCardWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        state: state,
        orderModel: widget.orderModel,
      );
}
