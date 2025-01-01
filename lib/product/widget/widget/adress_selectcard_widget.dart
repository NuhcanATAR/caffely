import 'package:caffely/feature/account/view/saved_adress/view/savedadress_create/savedadress_create_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

import '../text_widget/title_medium_text.dart';

class AdressSelectCardWidget extends StatelessWidget {
  const AdressSelectCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.selectedAddress,
    required this.addressList,
    required this.onChanged,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final SavedAdressModel? selectedAddress;
  final List<SavedAdressModel> addressList;
  final Function(SavedAdressModel?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dynamicViewExtensions.maxWidth(context),
      child: Container(
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
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
            // title
            Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingMediumValue,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BodyMediumBlackBoldText(
                      text: AppLocalizations.of(context)!.adress_select_title,
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
                    child: BodyMediumMainColorText(
                      text: AppLocalizations.of(context)!.adress_select_add,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),

            // adress select
            Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingNormalValue,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<SavedAdressModel>(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  icon: AppIcons.arrowDropDown.toSvgImg(
                    Colors.black,
                    BaseUtility.iconNormalSize,
                    BaseUtility.iconNormalSize,
                  ),
                  hint: BodyMediumBlackText(
                    text: AppLocalizations.of(context)!.adress_select,
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
                  onChanged: onChanged,
                ),
              ),
            ),
            // select adress
            if (selectedAddress != null)
              Container(
                padding: BaseUtility.all(
                  BaseUtility.paddingNormalValue,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      BaseUtility.radiusCircularMediumValue,
                    ),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    // title
                    SizedBox(
                      width: dynamicViewExtensions.maxWidth(context),
                      child: Container(
                        padding: BaseUtility.vertical(
                          BaseUtility.paddingNormalValue,
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
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.vertical(
                              BaseUtility.paddingNormalValue,
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
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: BaseUtility.bottom(
                              BaseUtility.paddingNormalValue,
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
    );
  }
}
