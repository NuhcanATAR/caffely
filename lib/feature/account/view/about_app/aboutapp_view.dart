import 'package:caffely/feature/account/view/about_app/aboutapp_viewmodel.dart';
import 'package:flutter/material.dart';

class AboutAppView extends StatefulWidget {
  const AboutAppView({super.key});

  @override
  State<AboutAppView> createState() => _AboutAppViewState();
}

class _AboutAppViewState extends AboutAppViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uygulama Hakkında"),
      ),
    );
  }
}
