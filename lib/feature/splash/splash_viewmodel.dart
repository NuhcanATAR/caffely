import 'package:caffely/feature/splash/splash_view.dart';
import 'package:caffely/feature/version/version_view.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding/onboarding_view.dart';
import '../sign_in/signin_loading_view.dart';

abstract class SplashViewModel extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await getCurrentVersion();
    await getCurrentUserControl();
  }

  Future<void> getCurrentUserControl() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String currentUserId = prefs.getString('user_id') ?? '';
      final bool isRememberMe = prefs.getBool('remember_me') ?? false;
      final int isAuthStatus = prefs.getInt('auth_status') ?? 0;
      if (isRememberMe == true && currentUserId.isNotEmpty) {
        await checkVersion(true);
      } else if (isAuthStatus == 2) {
        await checkVersion(true);
      } else {
        await checkVersion(false);
      }
    } catch (e) {
      Logger().e('Hata Oluştu: $e');
    }
  }

  Future<String> getCurrentVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<void> checkVersion(bool isRouter) async {
    final versionCollectionRef =
        FirebaseCollectionReferances.version.collectRef;

    final versionDocument = await versionCollectionRef.doc('android').get();

    if (versionDocument.exists) {
      final versionValue = versionDocument['version'];
      final currentVersion = await getCurrentVersion();

      if (versionValue == currentVersion) {
        Future.delayed(
          const Duration(seconds: 4),
          () {
            if (isRouter == true) {
              CodeNoahNavigatorRouter.pushAndRemoveUntil(
                context,
                const SignInLoadingView(),
              );
            } else {
              CodeNoahNavigatorRouter.pushAndRemoveUntil(
                context,
                const OnBoardingView(),
              );
            }
          },
        );
      } else {
        Future.delayed(
          const Duration(seconds: 4),
          () {
            CodeNoahNavigatorRouter.pushAndRemoveUntil(
              context,
              const VersionView(),
            );
          },
        );
      }
    } else {
      Logger().e('Version document does not exist');
    }
  }
}
