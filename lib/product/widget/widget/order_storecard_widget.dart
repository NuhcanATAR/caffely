import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/orderbasket_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../feature/store/view/store_detail/storedetail_view.dart';
import '../../core/database/firebase_database.dart';

class OrderStoreCardWidget extends StatelessWidget {
  const OrderStoreCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.storeModel,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final BasketBranchModel storeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        color: Theme.of(context).colorScheme.outline,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          RadiusUtility.circularHighValue,
                        ),
                      ),
                    ),
                    child:
                        AppLogoConstants.appLogoNoBackgroundColorPrimary.toImg,
                  ),
                ),
                // branch information
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseCollectionReferances.stores.collectRef
                        .doc(storeModel.id)
                        .get(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot,
                    ) {
                      if (snapshot.hasError) {
                        return const SizedBox();
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }

                      if (snapshot.hasData) {
                        final Map<String, dynamic> storeData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        final StoreModel storeModel = StoreModel.fromJson(
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
                            padding: PaddingSizedsUtility.horizontal(
                              PaddingSizedsUtility.normalPaddingValue,
                            ),
                            child: Column(
                              children: <Widget>[
                                // store title
                                SizedBox(
                                  width: dynamicViewExtensions.maxWidth(
                                    context,
                                  ),
                                  child: Padding(
                                    padding: PaddingSizedsUtility.vertical(
                                      PaddingSizedsUtility.smallPaddingValue,
                                    ),
                                    child: BodyMediumBlackBoldText(
                                      text: storeModel.storeName,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                // store location
                                SizedBox(
                                  width: dynamicViewExtensions.maxWidth(
                                    context,
                                  ),
                                  child: Padding(
                                    padding: PaddingSizedsUtility.bottom(
                                      PaddingSizedsUtility.smallPaddingValue,
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
        // store order status
        SizedBox(
          width: dynamicViewExtensions.maxWidth(context),
          child: Padding(
            padding: PaddingSizedsUtility.vertical(
              PaddingSizedsUtility.mediumPaddingValue,
            ),
            child: storeModel.status ==
                    OrderBranchStatusControl.orderRejected.value
                ? BodyMediumRedBoldText(
                    text:
                        '${AppLocalizations.of(context)!.order_status} : ${AppLocalizations.of(context)!.order_status_rejected}',
                    textAlign: TextAlign.left,
                  )
                : BodyMediumBlackBoldText(
                    text:
                        '${AppLocalizations.of(context)!.order_status}: ${storeModel.status == OrderBranchStatusControl.orderReceived.value ? AppLocalizations.of(context)!.order_status_received : storeModel.status == OrderBranchStatusControl.orderInProgress.value ? AppLocalizations.of(context)!.order_status_inprogress : storeModel.status == OrderBranchStatusControl.orderOnTheWay.value ? AppLocalizations.of(context)!.order_status_on_the_way : storeModel.status == OrderBranchStatusControl.orderDelivered.value ? AppLocalizations.of(context)!.order_status_delivered : storeModel.status == OrderBranchStatusControl.orderRejected.value ? AppLocalizations.of(context)!.order_status_rejected : AppLocalizations.of(context)!.order_status_unknow}',
                    textAlign: TextAlign.left,
                  ),
          ),
        ),
      ],
    );
  }
}
