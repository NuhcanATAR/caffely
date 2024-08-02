import 'package:caffely/feature/splash/splash_viewmodel.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends SplashViewModel {
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
