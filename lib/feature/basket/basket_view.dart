// ignore_for_file: deprecated_member_use, avoid_dynamic_calls

import 'package:caffely/feature/basket/basket_viewmodel.dart';
import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/feature/basket/view/order_complete/ordercomplete_view.dart';
import 'package:caffely/feature/store/view/store_detail/storedetail_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/productbasket_card_widget.dart';
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
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Sepet',
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            if (state is BasketLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BasketLoaded) {
              return state.isBasket == true
                  ? Column(
                      children: <Widget>[
                        // body
                        buildBodyWidget(state),
                        // footer button
                        buildFooterWidget(
                          state,
                          basketProductList,
                        ),
                      ],
                    )
                  : const CustomResponseWidget(
                      img: AppImages.notFound,
                      title: 'Sepetde Henüz Ürün Bulunmuyor',
                      subTitle:
                          'Sepetinizde henüz ürün bulunmuyor, isterseniz sepetinze ürün ekemeye başlayabilirsiniz.',
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

            return SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Container(
                padding: PaddingSizedsUtility.all(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
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
                                    .doc(branchesModel.id)
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
                            // button
                            Padding(
                              padding: PaddingSizedsUtility.right(
                                PaddingSizedsUtility.mediumPaddingValue,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<BasketBloc>()
                                      .toggleProductsVisibility();
                                },
                                child: AppIcons.arrowDropDown.toSvgImg(
                                  Theme.of(context).colorScheme.primary,
                                  IconSizedsUtility.normalSize,
                                  IconSizedsUtility.normalSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // products
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
                            return const SizedBox(
                              child: Text("Hatalı"),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              child: Text("asdas"),
                            );
                          }

                          if (snapshot.hasData) {
                            final List<BasketProductModel> basketProducts =
                                snapshot.data!.docs.map((doc) {
                              return BasketProductModel.fromJson(
                                doc.data() as Map<String, dynamic>,
                              );
                            }).toList();

                            if (basketProducts.isNotEmpty) {
                              basketProductList = basketProducts;
                            } else {
                              basketProductList = [];
                            }
                            return basketProducts.isEmpty
                                ? const BodyMediumBlackBoldText(
                                    text: 'Şubeye Ait Ürün Bulunmuyor',
                                    textAlign: TextAlign.center,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: basketProducts.length,
                                    itemBuilder: (context, index) {
                                      final productModel =
                                          basketProducts[index];

                                      return ProductBasketCardWidget(
                                        dynamicViewExtensions:
                                            dynamicViewExtensions,
                                        productModel: productModel,
                                        branchesModel: branchesModel,
                                        basketProducts: basketProducts,
                                      );
                                    },
                                  );
                          }
                          return const SizedBox(
                            child: Text("asdas"),
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  // footer
  CustomButtonWidget buildFooterWidget(
    BasketLoaded state,
    List<BasketProductModel> basketProducts,
  ) =>
      CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: 'Siparişi Tamamla',
        func: () {
          if (basketProducts.isNotEmpty) {
            CodeNoahNavigatorRouter.push(
              context,
              OrderCompleteView(
                branches: state.branches,
                basketProducts: basketProducts,
              ),
            );
          } else {
            CodeNoahDialogs(context).showFlush(
              type: SnackType.error,
              message: 'Sepetde Henüz Ürün Bulunmuyor',
            );
          }
        },
        btnStatus: ButtonTypes.primaryColorButton,
      );
}
