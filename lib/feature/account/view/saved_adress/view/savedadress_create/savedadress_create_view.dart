import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/state.dart';
import 'package:caffely/feature/account/view/saved_adress/view/savedadress_create/savedadress_create_viewmodel.dart';
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
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Adres Oluştur',
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<SavedAdressBloc, SavedAdressState>(
        listener: savedAdressCreateListenerBloc,
        builder: (context, state) {
          return Form(
            key: formAdressCreateKey,
            child: Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
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
              hintText: 'Adres Başlığı',
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
              hintText: 'Mahalle/Sokak',
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
                    padding: PaddingSizedsUtility.right(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: NumberTextFieldWidget(
                      controller: apartmentController,
                      hintText: 'Bina Numarası',
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
                    padding: PaddingSizedsUtility.left(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: NumberTextFieldWidget(
                      controller: floorController,
                      hintText: 'Kapı Numarası',
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
              hintText: 'Adres Tarifi',
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
                    padding: PaddingSizedsUtility.right(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: NormalTextFieldWidget(
                      controller: contactNameController,
                      hintText: 'Ad',
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
                    padding: PaddingSizedsUtility.left(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: NormalTextFieldWidget(
                      controller: contactSurnameController,
                      hintText: 'Soyad',
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
              hintText: 'Telefon Numarası',
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
        text: 'Adresi Kaydet',
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
