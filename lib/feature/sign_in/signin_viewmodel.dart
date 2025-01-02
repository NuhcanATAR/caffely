import 'package:caffely/feature/sign_in/bloc/mixin.dart';
import 'package:caffely/feature/sign_in/signin_loading_view.dart';
import 'package:caffely/feature/sign_in/signin_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class SignInViewModel extends BaseState<SignInView> with SignInMixin {
  final formSignInKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isRememberMe = false;

  @override
  void initState() {
    super.initState();
    currentUserLoad();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void rememberMeOnChanged(bool? value) {
    setState(() {
      isRememberMe = value!;
    });

    isRememberMe = value!;

    prefService.prefs.then((valuePrefs) {
      valuePrefs.setBool('remember_me', value);
      valuePrefs.setString('email', emailController.text);
      valuePrefs.setString('password', passwordController.text);
    });
    setState(() {
      isRememberMe = value;
    });
  }

  Future<void> currentUserLoad() async {
    try {
      final String email = await prefService.getString('email') ?? '';
      final String password = await prefService.getString('password') ?? '';
      final bool rememberMe = await prefService.getBool('remember_me') ?? false;

      if (rememberMe) {
        loggerPrint.printInfoLog('Beni hatırla açık');
        setState(() {
          isRememberMe = true;
        });
        emailController.text = email;
        passwordController.text = password;

        final FirebaseAuth auth = FirebaseAuth.instance;
        final User? user = auth.currentUser;

        if (user != null) {
          final String authID = user.uid;
          loggerPrint.printInfoLog('Current User ID: ${authID.toString()}');
          if (!mounted) return;
          CodeNoahNavigatorRouter.pushAndRemoveUntil(
            context,
            const SignInLoadingView(),
            direction: SlideDirection.rightToLeft,
          );
        } else {
          loggerPrint.printErrorLog('Error: No user found in current session!');
          if (!mounted) return;
          await CodeNoahDialogs(context).showFlush(
            type: SnackType.error,
            message: AppLocalizations.of(context)!.sign_user_not_found,
          );
        }
      }
    } catch (e) {
      loggerPrint.printErrorLog("Error: ${e.toString()}");
      if (!mounted) return;
      await CodeNoahDialogs(context).showFlush(
        type: SnackType.error,
        message: AppLocalizations.of(context)!.sign_user_not_found,
      );
    }
  }
}
