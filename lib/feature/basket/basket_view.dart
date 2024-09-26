import 'package:caffely/feature/basket/basket_viewmodel.dart';
import 'package:flutter/material.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends BasketViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepet"),
      ),
    );
  }
}
