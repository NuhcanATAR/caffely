import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/label_medium_text.dart';
import 'package:flutter/material.dart';

class StoreCardWidget extends StatelessWidget {
  const StoreCardWidget({
    super.key,
    required this.store,
    required this.dynamicViewExtensions,
    required this.func,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final StoreModel store;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingSizedsUtility.right(
        PaddingSizedsUtility.normalPaddingValue,
      ),
      child: GestureDetector(
        onTap: func,
        child: SizedBox(
          width: dynamicViewExtensions.dynamicWidth(
            context,
            0.4,
          ),
          child: Container(
            padding: PaddingSizedsUtility.all(
              PaddingSizedsUtility.smallPaddingValue,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  RadiusUtility.circularMediumValue,
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                // top
                Expanded(
                  flex: 4,
                  child: CachedNetworkImage(
                    imageUrl: store.coverImage.toString(),
                    imageBuilder: (
                      context,
                      imageProvider,
                    ) {
                      return Container(
                        padding: PaddingSizedsUtility.all(
                          PaddingSizedsUtility.smallPaddingValue,
                        ),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              RadiusUtility.circularMediumValue,
                            ),
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            RadiusUtility.circularMediumValue,
                          ),
                          topRight: Radius.circular(
                            RadiusUtility.circularMediumValue,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            RadiusUtility.circularMediumValue,
                          ),
                          topRight: Radius.circular(
                            RadiusUtility.circularMediumValue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // body
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
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
                              padding: PaddingSizedsUtility.all(
                                PaddingSizedsUtility.mediumPaddingValue,
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
                              padding: PaddingSizedsUtility.horizontal(
                                PaddingSizedsUtility.mediumPaddingValue,
                              ),
                              child: Row(
                                children: <Widget>[
                                  AppIcons.locationFill.toSvgImg(
                                    Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    IconSizedsUtility.mediumSize,
                                    IconSizedsUtility.mediumSize,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: PaddingSizedsUtility.left(
                                        PaddingSizedsUtility.smallPaddingValue,
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
    );
  }
}
