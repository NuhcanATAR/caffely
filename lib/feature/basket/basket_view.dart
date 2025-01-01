// ignore_for_file: deprecated_member_use, avoid_dynamic_calls

import 'package:caffely/feature/basket/basket_viewmodel.dart';
import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/basket_productslist_widget.dart';
import 'package:caffely/product/widget/widget/basket_storecard_widget.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends BasketViewModel {
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
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.basket_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            if (state is BasketLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BasketLoaded) {
              return state.isBasket == true
                  ? state.branches.isNotEmpty
                      ? Column(
                          children: <Widget>[
                            // body
                            buildBodyWidget(state),
                            // footer button
                            buildFooterWidget(state),
                          ],
                        )
                      : CustomResponseWidget(
                          img: AppImages.notFound,
                          title: AppLocalizations.of(context)!
                              .basket_product_empty_title,
                          subTitle: AppLocalizations.of(context)!
                              .basket_product_empty_subtitle,
                        )
                  : CustomResponseWidget(
                      img: AppImages.notFound,
                      title: AppLocalizations.of(context)!
                          .basket_product_empty_title,
                      subTitle: AppLocalizations.of(context)!
                          .basket_product_empty_subtitle,
                    );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  // body
  Expanded buildBodyWidget(BasketLoaded state) => Expanded(
        child: ListView.builder(
          itemCount: state.branches.length,
          itemBuilder: (context, index) {
            final branchesModel = state.branches[index];
            branchId = branchesModel.id;
            return SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Container(
                margin: BaseUtility.vertical(
                  BaseUtility.marginMediumValue,
                ),
                padding: BaseUtility.all(
                  BaseUtility.paddingNormalValue,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      BaseUtility.radiusNormalValue,
                    ),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    // store information
                    buildStoreInformationCardWidget(branchesModel),
                    // products
                    buildStoreProductsCardWidget(
                      state,
                      branchesModel,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  // store information
  Widget buildStoreInformationCardWidget(BasketBranchModel branchesModel) =>
      BasketStoreCardWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        branchesModel: branchesModel,
        hideOnTap: () {
          context.read<BasketBloc>().toggleProductsVisibility();
        },
      );

  // produts
  Widget buildStoreProductsCardWidget(
    BasketLoaded state,
    BasketBranchModel branchesModel,
  ) =>
      Column(
        children: <Widget>[
          if (state.isProductsVisible)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseCollectionReferances.basket.collectRef
                  .doc(FirebaseService().authID)
                  .collection(
                    FirebaseCollectionReferances.branch.name,
                  )
                  .doc(branchesModel.id)
                  .collection(
                    FirebaseCollectionReferances.product.name,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return SizedBox(
                    child: Text(
                      AppLocalizations.of(context)!.basket_product_error,
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }

                if (snapshot.hasData) {
                  basketProductList.clear();
                  final List<BasketProductModel> basketProducts =
                      snapshot.data!.docs.map((doc) {
                    return BasketProductModel.fromJson(
                      doc.data() as Map<String, dynamic>,
                    );
                  }).toList();

                  basketProductList.addAll(basketProducts);

                  return basketProducts.isEmpty
                      ? BodyMediumBlackBoldText(
                          text: AppLocalizations.of(context)!
                              .basket_store_product_empty,
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: basketProducts.length,
                          itemBuilder: (context, index) {
                            final productModel = basketProducts[index];
                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseCollectionReferances
                                  .product.collectRef
                                  .doc(
                                    productModel.productId,
                                  )
                                  .get(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot,
                              ) {
                                if (snapshot.hasError) {
                                  return SizedBox(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .basket_product_error,
                                    ),
                                  );
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }

                                if (snapshot.hasData && snapshot.data != null) {
                                  final data = snapshot.data!.data()
                                      as Map<String, dynamic>?;

                                  if (data == null) {
                                    return const SizedBox();
                                  }

                                  final ProductModel product =
                                      ProductModel.fromJson(
                                    data,
                                  );

                                  return BasketProductListWidget(
                                    product: product,
                                    dynamicViewExtensions:
                                        dynamicViewExtensions,
                                    productModel: productModel,
                                    productRemove: () {
                                      context.read<BasketBloc>().productRemove(
                                            branchesModel,
                                            productModel,
                                            product,
                                            basketProducts,
                                            context,
                                          );
                                    },
                                    produdctQuanityAdd: () {
                                      context
                                          .read<BasketBloc>()
                                          .productQuanityAdd(
                                            branchesModel,
                                            productModel,
                                            product,
                                            basketProducts,
                                          );
                                    },
                                    productQuanityReduce: () {
                                      context
                                          .read<BasketBloc>()
                                          .productQuanityReduce(
                                            branchesModel,
                                            productModel,
                                            product,
                                            basketProducts,
                                            context,
                                          );
                                    },
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
      );

  // footer
  CustomButtonWidget buildFooterWidget(
    BasketLoaded state,
  ) =>
      CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: AppLocalizations.of(context)!.basket_complete_btn,
        func: () => orderCompleteFunc(state),
        btnStatus: ButtonTypes.primaryColorButton,
      );
}
