import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/state.dart';
import 'package:caffely/feature/account/view/saved_adress/view/saved_adress_edit/saved_adress_edit_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/location_menu_widget.dart';
import 'package:caffely/product/widget/widget/normal_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAdressEditView extends StatefulWidget {
  const SavedAdressEditView({
    super.key,
    required this.savedAdressModel,
  });

  final SavedAdressModel savedAdressModel;

  @override
  State<SavedAdressEditView> createState() => _SavedAdressEditViewState();
}

class _SavedAdressEditViewState extends SavedadressEditViewmodel {
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
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.account_saveadress_edit_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<SavedAdressBloc, SavedAdressState>(
        listener: savedAdressEditListenerBloc,
        builder: (context, state) {
          return Form(
            key: formAdressEditKey,
            child: Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingNormalValue,
              ),
              child: Column(
                children: <Widget>[
                  // body
                  buildBodyWidget,
                  // footer
                  buildFooterWidget,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // body
  Expanded get buildBodyWidget => Expanded(
        child: ListView(
          children: <Widget>[
            // title
            NormalTextFieldWidget(
              controller: titleController,
              hintText: AppLocalizations.of(context)!.account_saveadress_title,
              explanationStatus: false,
              onChanged: (String value) {
                context
                    .read<SavedAdressBloc>()
                    .add(SavedAdressTitleEvent(value));
              },
              isValidator: true,
              enabled: true,
              isLabelText: true,
              dynamicViewExtensions: dynamicViewExtensions,
            ),
            // location
            LocationMenuWidget(
              selectedCity: selectedCity,
              selectedDistrict: selectedDistrict,
              onCityChanged: handleCityChanged,
              onDistrictChanged: handleDistrictChanged,
            ),
            // street
            NormalTextFieldWidget(
              controller: streetController,
              hintText: AppLocalizations.of(context)!.account_saveadress_street,
              explanationStatus: false,
              onChanged: (String value) {
                context
                    .read<SavedAdressBloc>()
                    .add(SavedAdressStreetEvent(value));
              },
              isValidator: true,
              enabled: true,
              isLabelText: true,
              dynamicViewExtensions: dynamicViewExtensions,
            ),
            // apartment no no & floor
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: BaseUtility.right(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: NumberTextFieldWidget(
                      controller: apartmentController,
                      hintText: AppLocalizations.of(context)!
                          .account_saveadress_apartment,
                      onChanged: (String value) {
                        context.read<SavedAdressBloc>().add(
                              SavedAdressApartmentNoEvent(value),
                            );
                      },
                      isLabelText: true,
                      dynamicViewExtensions: dynamicViewExtensions,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: BaseUtility.left(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: NumberTextFieldWidget(
                      controller: floorController,
                      hintText: AppLocalizations.of(context)!
                          .account_saveadress_floor,
                      onChanged: (String value) {
                        context
                            .read<SavedAdressBloc>()
                            .add(SavedAdressFloorEvent(value));
                      },
                      isLabelText: true,
                      dynamicViewExtensions: dynamicViewExtensions,
                    ),
                  ),
                ),
              ],
            ),
            // directions
            NormalTextFieldWidget(
              controller: directionController,
              hintText:
                  AppLocalizations.of(context)!.account_saveadress_directions,
              explanationStatus: false,
              onChanged: (String value) {
                context
                    .read<SavedAdressBloc>()
                    .add(SavedAdressDirectionsEvent(value));
              },
              isValidator: false,
              enabled: true,
              isLabelText: true,
              dynamicViewExtensions: dynamicViewExtensions,
            ),
            // contact name surname
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: BaseUtility.right(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: NormalTextFieldWidget(
                      controller: contactNameController,
                      hintText: AppLocalizations.of(context)!
                          .account_saveadress_contact_name,
                      explanationStatus: false,
                      onChanged: (String value) {
                        context.read<SavedAdressBloc>().add(
                              SavedAdressContactNameEvent(value),
                            );
                      },
                      isValidator: true,
                      enabled: true,
                      isLabelText: true,
                      dynamicViewExtensions: dynamicViewExtensions,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: BaseUtility.left(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: NormalTextFieldWidget(
                      controller: contactSurnameController,
                      hintText: AppLocalizations.of(context)!
                          .account_saveadress_contact_surname,
                      explanationStatus: false,
                      onChanged: (String value) {
                        context.read<SavedAdressBloc>().add(
                              SavedAdressContactSurnameEvent(
                                value,
                              ),
                            );
                      },
                      isValidator: true,
                      enabled: true,
                      isLabelText: true,
                      dynamicViewExtensions: dynamicViewExtensions,
                    ),
                  ),
                ),
              ],
            ),
            // contact phone number
            NumberTextFieldWidget(
              controller: contactPhoneController,
              hintText: AppLocalizations.of(context)!
                  .account_saveadress_contact_phone_number,
              onChanged: (String value) {
                context
                    .read<SavedAdressBloc>()
                    .add(SavedAdressContactPhoneNumberEvent(value));
              },
              isLabelText: true,
              dynamicViewExtensions: dynamicViewExtensions,
            ),
          ],
        ),
      );

  // footer
  CustomButtonWidget get buildFooterWidget => CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: AppLocalizations.of(context)!.account_saveadress_edit_btn,
        func: () {
          if (formAdressEditKey.currentState!.validate()) {
            if (selectedCity != null || selectedDistrict != null) {
              context.read<SavedAdressBloc>().add(
                    SaveAdressEditEvent(
                      widget.savedAdressModel,
                      titleController.text,
                      selectedCity!,
                      selectedDistrict!,
                      streetController.text,
                      int.parse(floorController.text),
                      int.parse(apartmentController.text),
                      directionController.text,
                      contactNameController.text,
                      contactSurnameController.text,
                      int.parse(
                        contactPhoneController.text,
                      ),
                      context,
                    ),
                  );
            } else {
              CodeNoahDialogs(context).showFlush(
                type: SnackType.error,
                message:
                    AppLocalizations.of(context)!.account_saveadress_city_error,
              );
            }
          }
        },
        btnStatus: ButtonTypes.primaryColorButton,
      );
}
