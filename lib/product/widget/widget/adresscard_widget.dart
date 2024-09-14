import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/view/savedadress_edit/savedadress_edit_view.dart';
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
      margin: MarginSizedsUtility.vertical(
        MarginSizedsUtility.normalMarginValue,
      ),
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
            width: dynamicViewExtensions.maxWidth(context),
            child: Container(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.normalPaddingValue,
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
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
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
                  padding: PaddingSizedsUtility.bottom(
                    PaddingSizedsUtility.normalPaddingValue,
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
                  padding: PaddingSizedsUtility.top(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: Row(
                    children: <Widget>[
                      AppIcons.locationOutline.toSvgImg(
                        Colors.black,
                        IconSizedsUtility.normalSize,
                        IconSizedsUtility.normalSize,
                      ),
                      Expanded(
                        child: Padding(
                          padding: PaddingSizedsUtility.horizontal(
                            PaddingSizedsUtility.normalPaddingValue,
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
                  padding: PaddingSizedsUtility.right(
                    PaddingSizedsUtility.smallPaddingValue,
                  ),
                  child: CustomButtonWidget(
                    dynamicViewExtensions: dynamicViewExtensions,
                    text: 'Düzenle',
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
                  padding: PaddingSizedsUtility.left(
                    PaddingSizedsUtility.smallPaddingValue,
                  ),
                  child: CustomButtonWidget(
                    dynamicViewExtensions: dynamicViewExtensions,
                    text: 'Sil',
                    func: () {
                      CodeNoahDialogs(context).showWarningAlert(
                        AppIcons.warningCircle,
                        Colors.red,
                        'Adresi Silmek İstiyormusunuz?',
                        dynamicViewExtensions,
                        () {
                          context.read<SavedAdressBloc>().add(
                                SaveAdressDeleteEvent(
                                  adressModel,
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
