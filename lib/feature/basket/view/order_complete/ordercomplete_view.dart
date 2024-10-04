import 'package:caffely/feature/account/view/saved_adress/view/savedadress_create/savedadress_create_view.dart';
import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/feature/basket/view/order_complete/ordercomplete_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/price_convert.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
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
        title: const BodyMediumBlackText(
          text: 'Siparişi Tamamla',
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<BasketBloc, BasketState>(
        listener: basketOrderCreateListenerBloc,
        builder: (context, state) {
          return Padding(
            padding: PaddingSizedsUtility.all(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: Column(
              children: <Widget>[
                // body
                Expanded(
                  child: ListView(
                    children: [
                      // adress select
                      SizedBox(
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                RadiusUtility.normalRadiusValue,
                              ),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              // title
                              Padding(
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.mediumPaddingValue,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: BodyMediumBlackBoldText(
                                        text: 'Teslimat Adresi',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        CodeNoahNavigatorRouter.push(
                                          context,
                                          const SavedadressCreateView(),
                                        );
                                      },
                                      child: const BodyMediumMainColorText(
                                        text: 'Adres Ekle',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // adress select
                              Padding(
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.normalPaddingValue,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<SavedAdressModel>(
                                    isExpanded: true,
                                    dropdownColor: Colors.white,
                                    icon: AppIcons.arrowDropDown.toSvgImg(
                                      Colors.black,
                                      IconSizedsUtility.normalSize,
                                      IconSizedsUtility.normalSize,
                                    ),
                                    hint: const BodyMediumBlackText(
                                      text: 'Teslimat Adresi Seçiniz',
                                      textAlign: TextAlign.left,
                                    ),
                                    value: selectedAddress,
                                    items: addressList.map((address) {
                                      return DropdownMenuItem<SavedAdressModel>(
                                        value: address,
                                        child: TitleMediumBlackBoldText(
                                          text: address.adressTitle,
                                          textAlign: TextAlign.left,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (SavedAdressModel? newValue) {
                                      setState(() {
                                        selectedAddress = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              // select adress
                              if (selectedAddress != null)
                                Container(
                                  padding: PaddingSizedsUtility.all(
                                    PaddingSizedsUtility.normalPaddingValue,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        RadiusUtility.circularMediumValue,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      // title
                                      SizedBox(
                                        width: dynamicViewExtensions
                                            .maxWidth(context),
                                        child: Container(
                                          padding:
                                              PaddingSizedsUtility.vertical(
                                            PaddingSizedsUtility
                                                .normalPaddingValue,
                                          ),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: TitleMediumBlackBoldText(
                                            text: selectedAddress!.adressTitle,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      // detail
                                      Column(
                                        children: <Widget>[
                                          // name surname & phone number
                                          SizedBox(
                                            width: dynamicViewExtensions
                                                .maxWidth(context),
                                            child: Padding(
                                              padding:
                                                  PaddingSizedsUtility.vertical(
                                                PaddingSizedsUtility
                                                    .normalPaddingValue,
                                              ),
                                              child: BodyMediumBlackBoldText(
                                                text:
                                                    '${selectedAddress!.contactName} ${selectedAddress!.contactSurname} (${selectedAddress!.contactPhoneNumber})',
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                          // street & apartment no & floor no
                                          SizedBox(
                                            width: dynamicViewExtensions
                                                .maxWidth(context),
                                            child: Padding(
                                              padding:
                                                  PaddingSizedsUtility.bottom(
                                                PaddingSizedsUtility
                                                    .normalPaddingValue,
                                              ),
                                              child: BodyMediumBlackText(
                                                text:
                                                    '${selectedAddress!.adressStreet} ${selectedAddress!.adressAparmentNo}/${selectedAddress!.adressFloor} ',
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      // payment type select
                      SizedBox(
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                RadiusUtility.normalRadiusValue,
                              ),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              // title
                              Padding(
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.mediumPaddingValue,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: BodyMediumBlackBoldText(
                                        text: 'Teslimat Adresi',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        CodeNoahNavigatorRouter.push(
                                          context,
                                          const SavedadressCreateView(),
                                        );
                                      },
                                      child: const BodyMediumMainColorText(
                                        text: 'Adres Ekle',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // payment select
                              Padding(
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.mediumPaddingValue,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: Row(
                                        children: <Widget>[
                                          Radio<PaymentType>(
                                            value: PaymentType.online,
                                            groupValue: selectedPaymentType,
                                            onChanged:
                                                (PaymentType? paymentValue) {
                                              setState(() {
                                                selectedPaymentType =
                                                    paymentValue;
                                              });
                                            },
                                          ),
                                          const BodyMediumBlackBoldText(
                                            text: 'Online Ödeme',
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: Row(
                                        children: <Widget>[
                                          Radio<PaymentType>(
                                            value: PaymentType.payAtTheDoor,
                                            groupValue: selectedPaymentType,
                                            onChanged:
                                                (PaymentType? paymentValue) {
                                              setState(() {
                                                selectedPaymentType =
                                                    paymentValue;
                                              });
                                            },
                                          ),
                                          const BodyMediumBlackBoldText(
                                            text: 'Kapıda Ödeme',
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // footer button
                Column(
                  children: <Widget>[
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseCollectionReferances.basket.collectRef
                          .doc(FirebaseService().authID)
                          .collection(FirebaseCollectionReferances.branch.name)
                          .get(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (snapshot.hasError) {
                          return const SizedBox();
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                      const Expanded(
                                        child: BodyMediumBlackText(
                                          text: 'Ürün Adeti',
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
                              // Toplam fiyat
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
                                      BodyMediumBlackBoldText(
                                        text:
                                            '${CodeNoahPriceConvert.formatPrice(totalPrice)}₺',
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Genel toplam
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
                                          text: 'Genel Toplam',
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
                      text: 'Siparişi Oluştur',
                      func: orderCreateBtn,
                      btnStatus: ButtonTypes.primaryColorButton,
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
