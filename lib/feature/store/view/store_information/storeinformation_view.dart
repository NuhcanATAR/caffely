import 'dart:async';

import 'package:caffely/feature/store/view/store_information/storeinformation_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreInformationView extends StatefulWidget {
  const StoreInformationView({
    super.key,
    required this.storeModel,
  });

  final StoreModel storeModel;

  @override
  State<StoreInformationView> createState() => _StoreInformationViewState();
}

class _StoreInformationViewState extends StoreInformationViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
        centerTitle: true,
        title: const BodyMediumBlackText(
          text: 'Şube Hakkında',
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
                children: <Widget>[
                  // opening time
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        AppIcons.timeOutline.toSvgImg(
                          Colors.black,
                          IconSizedsUtility.normalSize,
                          IconSizedsUtility.normalSize,
                        ),
                        Expanded(
                          child: Padding(
                            padding: PaddingSizedsUtility.horizontal(
                              PaddingSizedsUtility.normalPaddingValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text:
                                  "Şu saat'de açılıyor ${openDateTime.hour}:${openDateTime.minute}",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // close time
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        AppIcons.timeOutline.toSvgImg(
                          Colors.black,
                          IconSizedsUtility.normalSize,
                          IconSizedsUtility.normalSize,
                        ),
                        Expanded(
                          child: Padding(
                            padding: PaddingSizedsUtility.horizontal(
                              PaddingSizedsUtility.normalPaddingValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text:
                                  'Şu saate kadar açık: ${closeDateTime.hour}:${closeDateTime.minute}',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // adress
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        AppIcons.locationFill.toSvgImg(
                          Colors.black,
                          IconSizedsUtility.normalSize,
                          IconSizedsUtility.normalSize,
                        ),
                        Expanded(
                          child: Padding(
                            padding: PaddingSizedsUtility.horizontal(
                              PaddingSizedsUtility.normalPaddingValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text:
                                  '${widget.storeModel.locationNeighborhood} ${widget.storeModel.locationStreet} (${widget.storeModel.locationCity}/${widget.storeModel.locationDistrict}) ',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // trade name
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.smallPaddingValue,
                            ),
                            child: const BodyMediumBlackBoldText(
                              text: 'Satıcı Ticari Unvanı',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.smallPaddingValue,
                            ),
                            child: BodyMediumBlackText(
                              text: widget.storeModel.tradeName,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // paymnet types
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.smallPaddingValue,
                            ),
                            child: const BodyMediumBlackBoldText(
                              text: 'Ödeme Yöntemleri',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.smallPaddingValue,
                            ),
                            child: BodyMediumBlackText(
                              text: widget.storeModel.paymentTypes,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // delivery type
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.smallPaddingValue,
                            ),
                            child: const BodyMediumBlackBoldText(
                              text: 'Teslimat Ücreti',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.smallPaddingValue,
                            ),
                            child: const BodyMediumBlackText(
                              text:
                                  'Teslimat ücreti, mesafeye ve günün hangi saati olduğuna göre belirlenir.',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // min basket value
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.smallPaddingValue,
                            ),
                            child: const BodyMediumBlackBoldText(
                              text: 'Min. Sepet Tutarı',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.smallPaddingValue,
                            ),
                            child: BodyMediumBlackText(
                              text:
                                  "Bu şube ${widget.storeModel.minBasketAmount}TL'den daha düşük tutarlı siparişleri kabul etmemektedir.",
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
            // footer buttons
            Column(
              children: <Widget>[
                // google maps
                CustomButtonWidget(
                  dynamicViewExtensions: dynamicViewExtensions,
                  text: 'Yol Tarifi Al',
                  func: () async {
                    if (widget.storeModel.locationUrl.isEmpty) {
                      unawaited(
                        CodeNoahDialogs(context).showFlush(
                          type: SnackType.error,
                          message: 'Yol Tarifi Bulunamadı!',
                        ),
                      );
                    } else {
                      if (!await launchUrl(
                        Uri.parse(widget.storeModel.locationUrl),
                      )) {
                        throw ServiceException('Could not launch url');
                      }
                    }
                  },
                  btnStatus: ButtonTypes.borderPrimaryColorButton,
                ),
                // call
                CustomButtonWidget(
                  dynamicViewExtensions: dynamicViewExtensions,
                  text: 'Ara',
                  func: () async {
                    if (widget.storeModel.phoneNumber == 0) {
                      unawaited(
                        CodeNoahDialogs(context).showFlush(
                          type: SnackType.error,
                          message: 'Telefon Numarası bulunamadı!',
                        ),
                      );
                    } else {
                      if (!await launchUrl(
                        Uri.parse('tel:${widget.storeModel.phoneNumber}'),
                      )) {
                        throw ServiceException('Could not launch url');
                      }
                    }
                  },
                  btnStatus: ButtonTypes.primaryColorButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
