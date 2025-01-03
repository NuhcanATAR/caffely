import 'package:caffely/feature/account/view/personal_information/bloc/cubit.dart';
import 'package:caffely/feature/account/view/personal_information/bloc/event.dart';
import 'package:caffely/feature/account/view/personal_information/bloc/state.dart';
import 'package:caffely/feature/account/view/personal_information/personal_information_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/location_menu_widget.dart';
import 'package:caffely/product/widget/widget/normal_text_field_widget.dart';
import 'package:caffely/product/widget/widget/phone_number_field_widget.dart';
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
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
        title: BodyMediumBlackText(
          text:
              AppLocalizations.of(context)!.account_personal_information_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocConsumer<PersonalInformationBloc, PersonalInformationState>(
        listener: personalInformationUpdateListenerBloc,
        builder: (context, state) {
          return Padding(
            padding: BaseUtility.all(
              BaseUtility.paddingNormalValue,
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
                      hintText: AppLocalizations.of(context)!
                          .account_personal_information_name_surname,
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
                      hintText: AppLocalizations.of(context)!
                          .account_personal_information_phone_number,
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
  FutureBuilder get buildFooterButtonWidget => FutureBuilder<UserModel>(
        future: getUserFromFireStore(FirebaseService().authID!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          if (snapshot.hasData) {
            final userModel = snapshot.data!;
            return CustomButtonWidget(
              dynamicViewExtensions: dynamicViewExtensions,
              text: AppLocalizations.of(context)!
                  .account_personal_information_footer_btn,
              func: () {
                if (formPersonalInformationKey.currentState!.validate()) {
                  if (selectedCity != null || selectedDistrict != null) {
                    context.read<PersonalInformationBloc>().add(
                          PersonalInformationUpdatedEvent(
                            nameSurnameController.text,
                            int.parse(phoneNumberController.text),
                            selectedCity!,
                            selectedDistrict!,
                            context,
                            userModel,
                          ),
                        );
                  } else {
                    CodeNoahDialogs(context).showFlush(
                      type: SnackType.error,
                      message: AppLocalizations.of(context)!
                          .account_personal_information_city_error,
                    );
                  }
                }
              },
              btnStatus: ButtonTypes.primaryColorButton,
            );
          }

          return const SizedBox();
        },
      );
}
