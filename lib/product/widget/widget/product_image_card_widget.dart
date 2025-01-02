import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';

class ProductImageCardWidget extends StatelessWidget {
  const ProductImageCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.productModel,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dynamicViewExtensions.maxWidth(context),
      height: dynamicViewExtensions.dynamicHeight(
        context,
        0.4,
      ),
      child: CachedNetworkImage(
        imageUrl: productModel.coverImg,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                BaseUtility.radiusLowValue,
              ),
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                BaseUtility.radiusLowValue,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                BaseUtility.radiusLowValue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
