import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/state.dart';
import 'package:caffely/feature/account/view/saved_adress/view/savedadress_edit/savedadress_edit_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/locationmenu_widget.dart';
import 'package:caffely/product/widget/widget/normaltextfield_widget.dart';
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
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Adresi Düzenle',
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<SavedAdressBloc, SavedAdressState>(
        listener: savedAdressEditListenerBloc,
        builder: (context, state) {
          return Form(
            key: formAdressEditKey,
            child: Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
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
  CustomButtonWidget get buildFooterWidget => CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: 'Adresi Güncelle',
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
                      int.parse(contactPhoneController.text),
                    ),
                  );
            } else {
              CodeNoahDialogs(context).showFlush(
                type: SnackType.error,
                message: 'Lütfen şehir ve ilçe seçimi yapınız.',
              );
            }
          }
        },
        btnStatus: ButtonTypes.primaryColorButton,
      );
}
