import 'package:caffely/feature/account/view/security/security_viewmodel.dart';
import 'package:flutter/material.dart';

class SecurityView extends StatefulWidget {
  const SecurityView({super.key});

  @override
  State<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends SecurityViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Güvenlik Ayarı"),
      ),
    );
  }
}
