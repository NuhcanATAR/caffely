import 'package:caffely/feature/bottom_menu/bottom_menu_view.dart';
import 'package:caffely/feature/complete/complete_view.dart';
import 'package:caffely/feature/sign_in/sign_in_loading_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
            final data = snapshot.data?.data() as Map<String, dynamic>;
            if (data.isEmpty) {
              return const SizedBox();
            }
            final user = UserModel.fromJson(data);
            prefService.prefs.then((valuePrefs) {
              valuePrefs.setInt(
                'auth_status',
                user.authStatus,
              );
            });
            if (user.nameSurname.isEmpty) {
              Future.delayed(const Duration(seconds: 3), () {
                if (!context.mounted) return;
                CodeNoahNavigatorRouter.pushAndRemoveUntil(
                  context,
                  const ProfileCompleteView(),
                  direction: SlideDirection.rightToLeft,
                );
              });
            } else {
              Future.delayed(const Duration(seconds: 3), () {
                if (!context.mounted) return;
                CodeNoahNavigatorRouter.pushAndRemoveUntil(
                  context,
                  const BottomMenuView(),
                  direction: SlideDirection.rightToLeft,
                );
              });
            }
            return buildBodyWidget;
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  // body
  Widget get buildBodyWidget => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingNormalValue,
              ),
              child: LoadingAnimationWidget.hexagonDots(
                color: Theme.of(context).colorScheme.primary,
                size: BaseUtility.iconLargeSize,
              ),
            ),
            Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingNormalValue,
              ),
              child: BodyMediumBlackBoldText(
                text: AppLocalizations.of(context)!.sign_loading_subtitle,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );
}
