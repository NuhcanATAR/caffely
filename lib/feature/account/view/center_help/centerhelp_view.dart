import 'package:caffely/feature/account/view/center_help/centerhelp_viewmodel.dart';
import 'package:flutter/material.dart';

class CenterHelpView extends StatefulWidget {
  const CenterHelpView({super.key});

  @override
  State<CenterHelpView> createState() => _CenterHelpViewState();
}

class _CenterHelpViewState extends CenterHelpViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yardım Merkezi"),
      ),
    );
  }
}
