import 'package:caffely/feature/onboarding/onboarding_view.dart';
import 'package:caffely/feature/version/version_view.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await getCurrentVersion();
    await checkVersion();
  }

  Future<String> getCurrentVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<void> checkVersion() async {
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const OnBoardingView(),
              ),
              (route) => false,
            );
          },
        );
      } else {
        Future.delayed(
          const Duration(seconds: 4),
          () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const VersionView(),
              ),
              (route) => false,
            );
          },
        );
      }
    } else {
      Logger().e('Version document does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.hightPaddingValue,
        ),
        child: Column(
          children: <Widget>[
            // logo
            Expanded(
              child: Padding(
                padding: PaddingSizedsUtility.all(
                  PaddingSizedsUtility.hightPaddingValue,
                ),
                child: Center(
                  child: AppLogoConstants
                      .appLogoTextNoBackgroundColorPrimary.toImg,
                ),
              ),
            ),
            // loading
            const CircularProgressIndicator(
              strokeWidth: 6,
              strokeCap: StrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }
}
