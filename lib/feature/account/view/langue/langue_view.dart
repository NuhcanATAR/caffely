import 'package:caffely/feature/account/view/langue/langue_viewmodel.dart';
import 'package:flutter/material.dart';

class LangueView extends StatefulWidget {
  const LangueView({super.key});

  @override
  State<LangueView> createState() => _LangueViewState();
}

class _LangueViewState extends LangueViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dil Ayarı"),
      ),
    );
  }
}
