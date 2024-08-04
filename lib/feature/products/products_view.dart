import 'package:caffely/feature/products/products_viewmodel.dart';
import 'package:caffely/product/core/base/helper/productfilter_control.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({
    super.key,
    required this.isPopularFilter,
  });

  final ProductFilterControl isPopularFilter;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends ProductsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürünler"),
      ),
    );
  }
}
