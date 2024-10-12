import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/feature/basket/view/order_complete/ordercomplete_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/adress_selectcard_widget.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/paymenttype_selectcard_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCompleteView extends StatefulWidget {
  const OrderCompleteView({
    super.key,
    required this.branches,
    required this.basketProducts,
    required this.branchId,
  });

  final List<BasketBranchModel> branches;
  final List<BasketProductModel> basketProducts;
  final String branchId;

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
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.basket_order_complete_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<BasketBloc, BasketState>(
        listener: basketOrderCreateListenerBloc,
        builder: (context, state) {
          return BlocBuilder<BasketBloc, BasketState>(
            builder: (context, blocState) {
              if (blocState is BasketLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (blocState is BasketLoaded) {
                return Padding(
                  padding: PaddingSizedsUtility.all(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: Column(
                    children: <Widget>[
                      // body
                      buildBodyWidget,
                      // footer button
                      buildFooterButtonWidget(blocState),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }

  // body
  Expanded get buildBodyWidget => Expanded(
        child: ListView(
          children: [
            // adress select
            buildAdressSelectWidget,
            // payment type select
            buildPaymentTypeSelectWidget,
          ],
        ),
      );

  // adress select
  AdressSelectCardWidget get buildAdressSelectWidget => AdressSelectCardWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        selectedAddress: selectedAddress,
        addressList: addressList,
        onChanged: (SavedAdressModel? newValue) {
          setState(() {
            selectedAddress = newValue;
          });
        },
      );

  // payment type select
  PaymentTypeSelectCardWidget get buildPaymentTypeSelectWidget =>
      PaymentTypeSelectCardWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        onChangedOne: (
          PaymentType? paymentValue,
        ) {
          setState(() {
            selectedPaymentType = paymentValue;
          });
        },
        onChangedSecond: (
          PaymentType? paymentValue,
        ) {
          setState(() {
            selectedPaymentType = paymentValue;
          });
        },
        groupValueOne: selectedPaymentType,
        groupValueSecond: selectedPaymentType,
      );

  // footer button
  Column buildFooterButtonWidget(BasketLoaded blocState) => Column(
        children: <Widget>[
          FutureBuilder<QuerySnapshot>(
            future: FirebaseCollectionReferances.basket.collectRef
                .doc(FirebaseService().authID)
                .collection(
                  FirebaseCollectionReferances.branch.name,
                )
                .get(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasError) {
                return const SizedBox();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }

              if (snapshot.hasData && snapshot.data != null) {
                int totalQuantity = 0;
                int totalPrice = 0;

                for (final doc in snapshot.data!.docs) {
                  final BasketBranchModel branchModel =
                      BasketBranchModel.fromJson(
                    doc.data() as Map<String, dynamic>,
                  );

                  totalQuantity += branchModel.totalQuanity;
                  totalPrice += branchModel.basketTotal;
                }

                return Column(
                  children: <Widget>[
                    SizedBox(
                      width: dynamicViewExtensions.maxWidth(context),
                      child: Padding(
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: BodyMediumBlackText(
                                text: AppLocalizations.of(context)!
                                    .basket_order_complete_product_quanity,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            BodyMediumBlackBoldText(
                              text: CodeNoahPriceConvert.formatPrice(
                                totalQuantity,
                              ),
                              textAlign: TextAlign.right,
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
                            Expanded(
                              child: BodyMediumBlackText(
                                text: AppLocalizations.of(context)!
                                    .basket_order_complete_total_price,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            BodyMediumBlackBoldText(
                              text:
                                  '${CodeNoahPriceConvert.formatPrice(totalPrice)}₺',
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // main total
                    SizedBox(
                      width: dynamicViewExtensions.maxWidth(context),
                      child: Padding(
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: BodyMediumBlackText(
                                text: AppLocalizations.of(context)!
                                    .basket_order_complete_main_total,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            BodyMediumBlackBoldText(
                              text:
                                  '${CodeNoahPriceConvert.formatPrice(totalPrice)}₺',
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
          // order complete button
          CustomButtonWidget(
            dynamicViewExtensions: dynamicViewExtensions,
            text:
                AppLocalizations.of(context)!.basket_order_complete_create_btn,
            func: () => orderCreateBtn(blocState),
            btnStatus: ButtonTypes.primaryColorButton,
          ),
        ],
      );
}
