import 'package:caffely/feature/products/view/productdetail_viewmodel.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends ProductDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Hakkında"),
      ),
    );
  }
}
