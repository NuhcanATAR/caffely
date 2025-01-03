import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/view/saved_adress_edit/saved_adress_edit_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdressCardWidget extends StatelessWidget {
  const AdressCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.adressModel,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final SavedAdressModel adressModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: BaseUtility.vertical(
        BaseUtility.marginNormalValue,
      ),
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
                text: adressModel.adressTitle,
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
                        '${adressModel.contactName} ${adressModel.contactSurname} (${adressModel.contactPhoneNumber})',
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
                        '${adressModel.adressStreet} ${adressModel.adressAparmentNo}/${adressModel.adressFloor} ',
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              // city district
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: BaseUtility.top(
                    BaseUtility.paddingNormalValue,
                  ),
                  child: Row(
                    children: <Widget>[
                      AppIcons.locationOutline.toSvgImg(
                        Colors.black,
                        BaseUtility.iconNormalSize,
                        BaseUtility.iconNormalSize,
                      ),
                      Expanded(
                        child: Padding(
                          padding: BaseUtility.horizontal(
                            BaseUtility.paddingNormalValue,
                          ),
                          child: BodyMediumBlackText(
                            text:
                                '${adressModel.adressCity} / ${adressModel.adressDistrict}',
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
          // footer buttons
          Row(
            children: <Widget>[
              // edit
              Flexible(
                child: Padding(
                  padding: BaseUtility.right(
                    BaseUtility.paddingSmallValue,
                  ),
                  child: CustomButtonWidget(
                    dynamicViewExtensions: dynamicViewExtensions,
                    text: AppLocalizations.of(context)!.adress_edit_btn,
                    func: () {
                      CodeNoahNavigatorRouter.push(
                        context,
                        SavedAdressEditView(
                          savedAdressModel: adressModel,
                        ),
                      );
                    },
                    btnStatus: ButtonTypes.borderPrimaryColorButton,
                  ),
                ),
              ),
              // delete
              Flexible(
                child: Padding(
                  padding: BaseUtility.left(
                    BaseUtility.paddingSmallValue,
                  ),
                  child: CustomButtonWidget(
                    dynamicViewExtensions: dynamicViewExtensions,
                    text: AppLocalizations.of(context)!.adress_delete_btn,
                    func: () {
                      CodeNoahDialogs(context).showWarningAlert(
                        AppIcons.warningCircle,
                        Colors.red,
                        AppLocalizations.of(context)!.adress_dialog_title,
                        dynamicViewExtensions,
                        () {
                          context.read<SavedAdressBloc>().add(
                                SaveAdressDeleteEvent(
                                  adressModel,
                                  context,
                                ),
                              );
                        },
                        () {
                          Navigator.pop(context);
                        },
                      );
                    },
                    btnStatus: ButtonTypes.borderErrorColorButton,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
