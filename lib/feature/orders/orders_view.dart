import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const BodyMediumBlackText(
          text: 'Siparişlerim',
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
