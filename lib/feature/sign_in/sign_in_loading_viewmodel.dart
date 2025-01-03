import 'package:caffely/feature/sign/sign_view.dart';
import 'package:caffely/feature/sign_in/sign_in_loading_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:flutter/material.dart';

abstract class SignInLoadingViewmodel extends BaseState<SignInLoadingView> {
  @override
  void initState() {
    super.initState();
    setUserId();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserId();
    });
  }

  void setUserId() {
    prefService.prefs.then((valuePrefs) {
      valuePrefs.setString('user_id', FirebaseService().authID.toString());
    });
    loggerPrint.printInfoLog('Oturum ID Kaydedildi!');
  }

  void getUserId() {
    if (FirebaseService().authID == null) {
      CodeNoahNavigatorRouter.pushAndRemoveUntil(
        context,
        const SignView(),
      );
    }
  }
}
