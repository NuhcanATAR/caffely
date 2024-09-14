import 'package:caffely/feature/account/view/personal_information/bloc/cubit.dart';
import 'package:caffely/feature/account/view/personal_information/bloc/event.dart';
import 'package:caffely/feature/account/view/personal_information/bloc/state.dart';
import 'package:caffely/feature/account/view/personal_information/personalinformation_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/locationmenu_widget.dart';
import 'package:caffely/product/widget/widget/normaltextfield_widget.dart';
import 'package:caffely/product/widget/widget/phonenumberfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends PersonalInformationViewModel {
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
          text: 'Kişisel Bilgiler',
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<PersonalInformationBloc, PersonalInformationState>(
        listener: personalInformationUpdateListenerBloc,
        builder: (context, state) {
          return Padding(
            padding: PaddingSizedsUtility.all(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: Column(
              children: <Widget>[
                // body
                buildBodyWidget,
                // footer button
                buildFooterButtonWidget,
              ],
            ),
          );
        },
      ),
    );
  }

  // body
  Expanded get buildBodyWidget => Expanded(
        child: Form(
          key: formPersonalInformationKey,
          child: FutureBuilder<UserModel>(
            future: getUserFromFireStore(
              FirebaseService().authID.toString(),
            ),
            builder: (
              BuildContext context,
              AsyncSnapshot<UserModel> snapshot,
            ) {
              if (snapshot.hasError) {
                return const SizedBox();
              }

              if (snapshot.hasData) {
                final userModel = snapshot.data!;

                initializeControllers(userModel);

                return ListView(
                  children: <Widget>[
                    // name surname
                    NormalTextFieldWidget(
                      controller: nameSurnameController,
                      hintText: 'Ad Soyad',
                      explanationStatus: false,
                      onChanged: (val) {},
                      isValidator: true,
                      enabled: true,
                      isLabelText: true,
                      dynamicViewExtensions: dynamicViewExtensions,
                    ),
                    // phone number
                    PhoneNumberFieldWidget(
                      phoneNumberController: phoneNumberController,
                      hintText: 'Telefon Numarası',
                      onChanged: (val) {},
                      isLabelText: true,
                    ),

                    // location
                    LocationMenuWidget(
                      selectedCity: selectedCity,
                      selectedDistrict: selectedDistrict,
                      onCityChanged: handleCityChanged,
                      onDistrictChanged: handleDistrictChanged,
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      );

  // footer button
  CustomButtonWidget get buildFooterButtonWidget => CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: 'Profili Güncelle',
        func: () {
          if (formPersonalInformationKey.currentState!.validate()) {
            if (selectedCity != null || selectedDistrict != null) {
              context.read<PersonalInformationBloc>().add(
                    PersonalInformationUpdatedEvent(
                      nameSurnameController.text,
                      int.parse(phoneNumberController.text),
                      selectedCity!,
                      selectedDistrict!,
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
