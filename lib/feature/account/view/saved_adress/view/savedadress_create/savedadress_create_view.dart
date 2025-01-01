import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/state.dart';
import 'package:caffely/feature/account/view/saved_adress/view/savedadress_create/savedadress_create_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/locationmenu_widget.dart';
import 'package:caffely/product/widget/widget/normaltextfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedadressCreateView extends StatefulWidget {
  const SavedadressCreateView({super.key});

  @override
  State<SavedadressCreateView> createState() => _SavedadressCreateViewState();
}

class _SavedadressCreateViewState extends SavedAdressCreateViewModel {
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
          text: AppLocalizations.of(context)!.account_saveadress_create_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<SavedAdressBloc, SavedAdressState>(
        listener: savedAdressCreateListenerBloc,
        builder: (context, state) {
          return Form(
            key: formAdressCreateKey,
            child: Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingNormalValue,
              ),
              child: Column(
                children: <Widget>[
                  // body
                  buildBodyWidget,
                  // footer
                  buildFooterWidget(state),
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
            // city & district
            LocationMenuWidget(
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
  CustomButtonWidget buildFooterWidget(SavedAdressState state) =>
      CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: AppLocalizations.of(context)!.account_saveadress_save_button,
        func: state.adressTitle.isEmpty ||
                selectedCity == null ||
                selectedDistrict == null ||
                state.adressStreet.isEmpty ||
                state.adressAparmentNo.isEmpty ||
                state.adressFloor.isEmpty ||
                state.contactName.isEmpty ||
                state.contactSurname.isEmpty ||
                state.contactPhoneNumber.isEmpty
            ? () {}
            : () {
                if (formAdressCreateKey.currentState!.validate()) {
                  context.read<SavedAdressBloc>().add(
                        SaveAdressCreateEvent(
                          state.adressTitle,
                          selectedCity!,
                          selectedDistrict!,
                          state.adressStreet,
                          int.parse(state.adressFloor),
                          int.parse(state.adressAparmentNo),
                          state.adressDirections,
                          state.contactName,
                          state.contactSurname,
                          int.parse(state.contactPhoneNumber),
                          context,
                        ),
                      );
                }
              },
        btnStatus: state.adressTitle.isEmpty ||
                selectedCity == null ||
                selectedDistrict == null ||
                state.adressStreet.isEmpty ||
                state.adressAparmentNo.isEmpty ||
                state.adressFloor.isEmpty ||
                state.contactName.isEmpty ||
                state.contactSurname.isEmpty ||
                state.contactPhoneNumber.isEmpty
            ? ButtonTypes.borderPrimaryColorButton
            : ButtonTypes.primaryColorButton,
      );
}
