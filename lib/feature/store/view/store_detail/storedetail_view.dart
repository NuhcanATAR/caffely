import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:flutter/material.dart';

class StoreDetailView extends StatefulWidget {
  const StoreDetailView({
    super.key,
    required this.storeModel,
  });

  final StoreModel storeModel;

  @override
  State<StoreDetailView> createState() => _StoreDetailViewState();
}

class _StoreDetailViewState extends State<StoreDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mağaza Detayı"),
      ),
    );
  }
}
