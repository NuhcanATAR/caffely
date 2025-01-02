// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/store_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/label_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:flutter/material.dart';

class StoreCardWidget extends StatelessWidget {
  const StoreCardWidget({
    super.key,
    required this.store,
    required this.dynamicViewExtensions,
    required this.func,
    required this.isCardStatus,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final StoreModel store;
  final Function() func;
  final bool isCardStatus;

  @override
  Widget build(BuildContext context) {
    return isCardStatus == true
        ? Padding(
            padding: BaseUtility.right(
              BaseUtility.paddingNormalValue,
            ),
            child: GestureDetector(
              onTap: func,
              child: SizedBox(
                width: dynamicViewExtensions.dynamicWidth(
                  context,
                  0.4,
                ),
                child: Container(
                  padding: BaseUtility.all(
                    BaseUtility.paddingSmallValue,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        BaseUtility.radiusCircularMediumValue,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      // top
                      Expanded(
                        flex: 5,
                        child: CachedNetworkImage(
                          imageUrl: store.coverImage.toString(),
                          imageBuilder: (
                            context,
                            imageProvider,
                          ) {
                            return Container(
                              padding: BaseUtility.all(
                                BaseUtility.paddingSmallValue,
                              ),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    BaseUtility.radiusCircularMediumValue,
                                  ),
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                                topRight: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                                topRight: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // body
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // title
                                SizedBox(
                                  width: dynamicViewExtensions.maxWidth(
                                    context,
                                  ),
                                  child: Padding(
                                    padding: BaseUtility.all(
                                      BaseUtility.paddingMediumValue,
                                    ),
                                    child: BodyMediumBlackBoldText(
                                      text: store.storeName,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                // location
                                SizedBox(
                                  width: dynamicViewExtensions.maxWidth(
                                    context,
                                  ),
                                  child: Padding(
                                    padding: BaseUtility.horizontal(
                                      BaseUtility.paddingMediumValue,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        AppIcons.locationFill.toSvgImg(
                                          Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          BaseUtility.iconMediumSize,
                                          BaseUtility.iconMediumSize,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: BaseUtility.left(
                                              BaseUtility.paddingSmallValue,
                                            ),
                                            child: LabelMediumBlackText(
                                              text:
                                                  '${store.locationCity} / ${store.locationNeighborhood}',
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: BaseUtility.vertical(
              BaseUtility.paddingNormalValue,
            ),
            child: GestureDetector(
              onTap: func,
              child: SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                height: dynamicViewExtensions.dynamicHeight(context, 0.34),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        BaseUtility.radiusCircularMediumValue,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      // cover image
                      Expanded(
                        flex: 4,
                        child: CachedNetworkImage(
                          imageUrl: store.coverImage.toString(),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    BaseUtility.radiusCircularMediumValue,
                                  ),
                                  topRight: Radius.circular(
                                    BaseUtility.radiusCircularMediumValue,
                                  ),
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                                topRight: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                                topRight: Radius.circular(
                                  BaseUtility.radiusCircularMediumValue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // information
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: Padding(
                          padding: BaseUtility.all(
                            BaseUtility.paddingSmallValue,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                // title
                                SizedBox(
                                  width:
                                      dynamicViewExtensions.maxWidth(context),
                                  child: Padding(
                                    padding: BaseUtility.vertical(
                                      BaseUtility.paddingNormalValue,
                                    ),
                                    child: TitleMediumBlackBoldText(
                                      text: store.storeName,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                // min basket price
                                SizedBox(
                                  width:
                                      dynamicViewExtensions.maxWidth(context),
                                  child: Padding(
                                    padding: BaseUtility.vertical(
                                      BaseUtility.paddingSmallValue,
                                    ),
                                    child: BodyMediumBlackText(
                                      text:
                                          '${store.minBasketAmount}${AppLocalizations.of(context)!.store_card_min_basket_value}',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                // delivery time
                                SizedBox(
                                  width:
                                      dynamicViewExtensions.maxWidth(context),
                                  child: Padding(
                                    padding: BaseUtility.vertical(
                                      BaseUtility.paddingSmallValue,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        // icon
                                        AppIcons.timeOutline.toSvgImg(
                                          Theme.of(context).colorScheme.primary,
                                          BaseUtility.iconNormalSize,
                                          BaseUtility.iconNormalSize,
                                        ),
                                        // information
                                        Expanded(
                                          child: Padding(
                                            padding: BaseUtility.horizontal(
                                              BaseUtility.paddingSmallValue,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        BaseUtility.horizontal(
                                                      BaseUtility
                                                          .paddingSmallValue,
                                                    ),
                                                    child: BodyMediumBlackText(
                                                      text: store.deliveryTimeFrame ==
                                                              StoreDeliveryTimeFrameControl
                                                                  .deliveryTimeFramOne
                                                                  .deliveryTimeFrameValue
                                                          ? StoreDeliveryTimeFrameControl
                                                              .deliveryTimeFramOne
                                                              .deliveryTimeFrameStringValue
                                                          : store.deliveryTimeFrame ==
                                                                  StoreDeliveryTimeFrameControl
                                                                      .deliveryTimeFramTwo
                                                                      .deliveryTimeFrameValue
                                                              ? StoreDeliveryTimeFrameControl
                                                                  .deliveryTimeFramTwo
                                                                  .deliveryTimeFrameStringValue
                                                              : store.deliveryTimeFrame ==
                                                                      StoreDeliveryTimeFrameControl
                                                                          .deliveryTimeFramThree
                                                                          .deliveryTimeFrameValue
                                                                  ? StoreDeliveryTimeFrameControl
                                                                      .deliveryTimeFramThree
                                                                      .deliveryTimeFrameStringValue
                                                                  : '',
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  fit: FlexFit.tight,
                                                  flex: 1,
                                                  child: store.freeDelivery ==
                                                          true
                                                      ? BodyMediumMainColorBoldText(
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .store_card_free_delivery,
                                                          textAlign:
                                                              TextAlign.left,
                                                        )
                                                      : const SizedBox(),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
