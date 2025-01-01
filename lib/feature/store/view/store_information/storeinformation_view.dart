import 'dart:async';

import 'package:caffely/feature/store/view/store_information/storeinformation_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
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
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
        centerTitle: true,
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.stores_information_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        child: Column(
          children: <Widget>[
            // body
            Expanded(
              child: ListView(
                children: <Widget>[
                  // opening time
                  Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        AppIcons.timeOutline.toSvgImg(
                          Colors.black,
                          BaseUtility.iconNormalSize,
                          BaseUtility.iconNormalSize,
                        ),
                        Expanded(
                          child: Padding(
                            padding: BaseUtility.horizontal(
                              BaseUtility.paddingNormalValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text:
                                  "${AppLocalizations.of(context)!.stores_information_opening_time} ${openDateTime.hour}:${openDateTime.minute}",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // close time
                  Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        AppIcons.timeOutline.toSvgImg(
                          Colors.black,
                          BaseUtility.iconNormalSize,
                          BaseUtility.iconNormalSize,
                        ),
                        Expanded(
                          child: Padding(
                            padding: BaseUtility.horizontal(
                              BaseUtility.paddingNormalValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text:
                                  '${AppLocalizations.of(context)!.stores_information_close_time}: ${closeDateTime.hour}:${closeDateTime.minute}',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // adress
                  Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        AppIcons.locationFill.toSvgImg(
                          Colors.black,
                          BaseUtility.iconNormalSize,
                          BaseUtility.iconNormalSize,
                        ),
                        Expanded(
                          child: Padding(
                            padding: BaseUtility.horizontal(
                              BaseUtility.paddingNormalValue,
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
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text: AppLocalizations.of(context)!
                                  .stores_information_trade_name,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
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
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text: AppLocalizations.of(context)!
                                  .stores_information_payment_type,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
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
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text: AppLocalizations.of(context)!
                                  .stores_information_delivery_type,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: BodyMediumBlackText(
                              text: AppLocalizations.of(context)!
                                  .stores_information_delivery_type_explanation,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // min basket value
                  Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: BodyMediumBlackBoldText(
                              text: AppLocalizations.of(context)!
                                  .stores_information_min_basket_value,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: BodyMediumBlackText(
                              text:
                                  "${AppLocalizations.of(context)!.stores_information_min_basket_explanation} ${widget.storeModel.minBasketAmount}${AppLocalizations.of(context)!.stores_information_min_basket_explanation_second}",
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
                  text: AppLocalizations.of(context)!
                      .stores_information_location_btn,
                  func: () async {
                    if (widget.storeModel.locationUrl.isEmpty) {
                      unawaited(
                        CodeNoahDialogs(context).showFlush(
                          type: SnackType.error,
                          message: AppLocalizations.of(context)!
                              .stores_information_location_not_found,
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
                  text:
                      AppLocalizations.of(context)!.stores_information_call_btn,
                  func: () async {
                    if (widget.storeModel.phoneNumber == 0) {
                      unawaited(
                        CodeNoahDialogs(context).showFlush(
                          type: SnackType.error,
                          message: AppLocalizations.of(context)!
                              .stores_information_call_error,
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
