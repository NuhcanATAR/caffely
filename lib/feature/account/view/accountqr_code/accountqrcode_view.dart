// ignore_for_file: avoid_dynamic_calls

import 'package:animate_do/animate_do.dart';
import 'package:caffely/feature/account/view/accountqr_code/accountqrcode_viewmodel.dart';
import 'package:caffely/feature/account/view/accountqr_code/bloc/cubit.dart';
import 'package:caffely/feature/account/view/accountqr_code/bloc/event.dart';
import 'package:caffely/feature/account/view/accountqr_code/bloc/state.dart';
import 'package:caffely/feature/account/view/accountqr_code/view/loading_view.dart';
import 'package:caffely/feature/bottom_menu/bottommenu_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/base/helper/auth_control.dart';
import 'package:caffely/product/core/base/helper/bottommenu_control.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountQrCodeView extends StatefulWidget {
  const AccountQrCodeView({super.key});

  @override
  State<AccountQrCodeView> createState() => _AccountQrCodeViewState();
}

class _AccountQrCodeViewState extends AccountQrCodeViewModel {
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
            CodeNoahNavigatorRouter.push(
              context,
              const BottomMenuView(
                startView: BottomMenuViews.profile,
              ),
            );
          },
          icon: AppIcons.arrowLeft.toSvgImg(
            Colors.black,
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Caffely Profil QR Kod',
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: BlocBuilder<QrCodeCubit, QrCodeState>(
          bloc: qrCodeCubit,
          builder: (context, state) {
            if (state is QrCodeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QrCodeExistState) {
              return buildQrCodeExistWidget(state);
            } else if (state is QrCodeNotExistState) {
              return buildQrCodeResponseWidget(state);
            } else if (state is QrCodeErrorState) {
              return buildQrCodeResponseWidget(state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // qr code response widget
  Widget buildQrCodeResponseWidget(state) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // img
            FadeInDown(
              child: Padding(
                padding: PaddingSizedsUtility.horizontal(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: AppImages.qrCodeNotFound.toSvgImg(
                  null,
                  dynamicViewExtensions.maxWidth(context),
                  dynamicViewExtensions.dynamicHeight(
                    context,
                    0.3,
                  ),
                ),
              ),
            ),
            // title
            FadeInLeft(
              child: Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: TitleMediumBlackBoldText(
                  text: state.title,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // sub title
            FadeInRight(
              child: Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: BodyMediumBlackText(
                  text: state.subTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // button
            FadeInUp(
              child: CustomButtonWidget(
                dynamicViewExtensions: dynamicViewExtensions,
                text: 'QR Kod Oluştur',
                func: () {
                  context.read<QrCodeCubit>().add(QrCodeCreateEvent());
                  CodeNoahNavigatorRouter.push(
                    context,
                    const AccountQrCodeCreateLoadingView(),
                  );
                },
                btnStatus: ButtonTypes.primaryColorButton,
              ),
            ),
          ],
        ),
      );

  // qr code exist widget
  Widget buildQrCodeExistWidget(state) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // profile card
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: FutureBuilder(
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

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // profile image
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: userModel.authStatus ==
                                      AuthControl.emailPasswordAuth.valueAuth
                                  ? BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(
                                        RadiusUtility.circularHighValue,
                                      ),
                                    )
                                  : BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          userModel.profileImage,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        RadiusUtility.circularHighValue,
                                      ),
                                    ),
                              child: userModel.authStatus ==
                                      AuthControl.emailPasswordAuth.valueAuth
                                  ? AppIcons.userOutline.toSvgImg(
                                      Colors.white,
                                      IconSizedsUtility.normalSize,
                                      IconSizedsUtility.normalSize,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                          // name surname
                          Padding(
                            padding: PaddingSizedsUtility.vertical(
                              PaddingSizedsUtility.normalPaddingValue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // name surname
                                Padding(
                                  padding: PaddingSizedsUtility.vertical(
                                    PaddingSizedsUtility.smallPaddingValue,
                                  ),
                                  child: TitleMediumBlackBoldText(
                                    text: userModel.nameSurname,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                // verification
                                Padding(
                                  padding: PaddingSizedsUtility.vertical(
                                    PaddingSizedsUtility.smallPaddingValue,
                                  ),
                                  child: const BodyMediumMainColorText(
                                    text: 'Doğrulanmış Hesap',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            // qr code
            Expanded(
              flex: 5,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.network(state.qrCodeUrl),
              ),
            ),
            const Spacer(),
          ],
        ),
      );
}
