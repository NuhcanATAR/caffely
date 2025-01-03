import 'package:caffely/feature/store/view/store_detail/store_detail_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BasketStoreCardWidget extends StatelessWidget {
  const BasketStoreCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.branchesModel,
    required this.hideOnTap,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final BasketBranchModel branchesModel;
  final Function() hideOnTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dynamicViewExtensions.maxWidth(context),
      child: Padding(
        padding: BaseUtility.vertical(
          BaseUtility.paddingMediumValue,
        ),
        child: Row(
          children: <Widget>[
            // branch logo
            SizedBox(
              width: 40,
              height: 40,
              child: Container(
                padding: BaseUtility.all(
                  BaseUtility.paddingSmallValue,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      BaseUtility.radiusCircularHighValue,
                    ),
                  ),
                ),
                child: AppLogoConstants.appLogoNoBackgroundColorPrimary.toImg,
              ),
            ),
            // branch information
            Expanded(
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseCollectionReferances.stores.collectRef
                    .doc(branchesModel.id)
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
                        padding: BaseUtility.horizontal(
                          BaseUtility.paddingNormalValue,
                        ),
                        child: Column(
                          children: <Widget>[
                            // store title
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(
                                context,
                              ),
                              child: Padding(
                                padding: BaseUtility.vertical(
                                  BaseUtility.paddingSmallValue,
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
                                padding: BaseUtility.bottom(
                                  BaseUtility.paddingSmallValue,
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
              padding: BaseUtility.right(
                BaseUtility.paddingMediumValue,
              ),
              child: GestureDetector(
                onTap: hideOnTap,
                child: AppIcons.arrowDropDown.toSvgImg(
                  Theme.of(context).colorScheme.primary,
                  BaseUtility.iconNormalSize,
                  BaseUtility.iconNormalSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
