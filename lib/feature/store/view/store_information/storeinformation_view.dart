import 'package:flutter/material.dart';

class StoreInformationView extends StatefulWidget {
  const StoreInformationView({super.key});

  @override
  State<StoreInformationView> createState() => _StoreInformationViewState();
}

class _StoreInformationViewState extends State<StoreInformationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mağaza Detaylı Bilgi"),
      ),
    );
  }
}
