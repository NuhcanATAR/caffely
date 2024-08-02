import 'package:caffely/feature/bottom_menu/bottommenu_viewmodel.dart';
import 'package:flutter/material.dart';

class BottomMenuView extends StatefulWidget {
  const BottomMenuView({super.key});

  @override
  State<BottomMenuView> createState() => _BottomMenuViewState();
}

class _BottomMenuViewState extends BottomMenuViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alt Menüler"),
      ),
    );
  }
}
