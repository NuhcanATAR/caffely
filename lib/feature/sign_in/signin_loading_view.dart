import 'package:caffely/feature/bottom_menu/bottommenu_view.dart';
import 'package:caffely/feature/complete/complete_view.dart';
import 'package:caffely/feature/sign_in/signin_loading_viewmodel.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInLoadingView extends StatefulWidget {
  const SignInLoadingView({super.key});

  @override
  State<SignInLoadingView> createState() => _SignInLoadingViewState();
}

class _SignInLoadingViewState extends SignInLoadingViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseCollectionReferances.users.collectRef
            .doc(FirebaseService().authID)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.hasData) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final user = UserModel.fromJson(data);
            SharedPreferences.getInstance().then((valuePrefs) {
              valuePrefs.setInt(
                'auth_status',
                user.authStatus,
              );
            });
            if (user.nameSurname.isEmpty) {
              Future.delayed(const Duration(seconds: 3), () {
                CodeNoahNavigatorRouter.pushAndRemoveUntil(
                  context,
                  const ProfileCompleteView(),
                  direction: SlideDirection.rightToLeft,
                );
              });
            } else {
              Future.delayed(const Duration(seconds: 3), () {
                CodeNoahNavigatorRouter.pushAndRemoveUntil(
                  context,
                  const BottomMenuView(),
                  direction: SlideDirection.rightToLeft,
                );
              });
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: LoadingAnimationWidget.hexagonDots(
                      color: Theme.of(context).colorScheme.primary,
                      size: IconSizedsUtility.largeSize,
                    ),
                  ),
                  Padding(
                    padding: PaddingSizedsUtility.vertical(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: const BodyMediumBlackBoldText(
                      text: 'Lütfen Bekleyiniz...',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
