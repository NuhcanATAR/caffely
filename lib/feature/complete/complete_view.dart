import 'package:animate_do/animate_do.dart';
import 'package:caffely/feature/complete/bloc/cubit.dart';
import 'package:caffely/feature/complete/bloc/event.dart';
import 'package:caffely/feature/complete/bloc/state.dart';
import 'package:caffely/feature/complete/complete_viewmodel.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/locationmenu_widget.dart';
import 'package:caffely/product/widget/widget/normaltextfield_widget.dart';
import 'package:caffely/product/widget/widget/phonenumberfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCompleteView extends StatefulWidget {
  const ProfileCompleteView({super.key});

  @override
  State<ProfileCompleteView> createState() => _ProfileCompleteViewState();
}

class _ProfileCompleteViewState extends ProfileCompleteViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<ProfileCompleteBloc, ProfileCompleteState>(
        listener: profileCompleteListenerBloc,
        builder: (BuildContext context, state) {
          return Form(
            key: formProfileCompleteKey,
            child: Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
              ),
              child: Column(
                children: <Widget>[
                  // body
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        // title & sub title
                        Padding(
                          padding: PaddingSizedsUtility.vertical(
                            PaddingSizedsUtility.normalPaddingValue,
                          ),
                          child: Column(
                            children: <Widget>[
                              // title
                              SizedBox(
                                width: dynamicViewExtensions.maxWidth(context),
                                child: Padding(
                                  padding: PaddingSizedsUtility.bottom(
                                    PaddingSizedsUtility.normalPaddingValue,
                                  ),
                                  child: FadeInLeft(
                                    child: const TitleLargeBlackBoldText(
                                      text:
                                          "Caffely Hesap Bilgilerini Tamamla👤.",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              // sub title
                              SizedBox(
                                width: dynamicViewExtensions.maxWidth(context),
                                child: Padding(
                                  padding: PaddingSizedsUtility.bottom(
                                    PaddingSizedsUtility.normalPaddingValue,
                                  ),
                                  child: FadeInLeft(
                                    child: const BodyMediumBlackText(
                                      text:
                                          "Başlamak için hesap bilgilerini tamamlamalısın.",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // name surname
                        NormalTextFieldWidget(
                          controller: nameSurnameController,
                          hintText: 'Ad Soyad',
                          explanationStatus: false,
                          onChanged: (String value) {
                            context.read<ProfileCompleteBloc>().add(
                                  ProfileCompleteNameSurnameEvent(value),
                                );
                          },
                          isValidator: true,
                          enabled: true,
                          isLabelText: true,
                          dynamicViewExtensions: dynamicViewExtensions,
                        ),
                        // phone number
                        PhoneNumberFieldWidget(
                          phoneNumberController: phoneNumberController,
                          hintText: 'Telefon Numarası',
                          onChanged: (String value) {
                            context.read<ProfileCompleteBloc>().add(
                                  ProfileCompletePhoneNumberEvent(value),
                                );
                          },
                          isLabelText: true,
                        ),
                        // city & district
                        LocationMenuWidget(
                          onCityChanged: handleCityChanged,
                          onDistrictChanged: handleDistrictChanged,
                        ),
                      ],
                    ),
                  ),
                  // footer button
                  FadeInUp(
                    child: CustomButtonWidget(
                      dynamicViewExtensions: dynamicViewExtensions,
                      text: 'Tamamla',
                      func: () {
                        if (formProfileCompleteKey.currentState!.validate()) {
                          if (selectedCity != null &&
                              selectedDistrict != null) {
                            context.read<ProfileCompleteBloc>().add(
                                  ProfileCompleteUser(
                                    state.nameSurname,
                                    int.parse(state.phoneNumber),
                                    selectedCity!,
                                    selectedDistrict!,
                                    dynamicViewExtensions,
                                  ),
                                );
                          } else {
                            CodeNoahDialogs(context).showFlush(
                              type: SnackType.error,
                              message: 'Lütfen Şehir ve İlçe Bilgisi seçiniz.',
                            );
                          }
                        }
                      },
                      btnStatus: ButtonTypes.primaryColorButton,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
