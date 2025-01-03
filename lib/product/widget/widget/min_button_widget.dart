import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';

class MinButtonWidget extends StatelessWidget {
  const MinButtonWidget({
    super.key,
    required this.func,
    required this.icon,
  });

  final Function() func;
  final AppIcons icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        margin: BaseUtility.horizontal(
          BaseUtility.marginSmallValue,
        ),
        padding: BaseUtility.all(
          BaseUtility.paddingMediumValue,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              BaseUtility.radiusCircularMediumValue,
            ),
          ),
        ),
        child: icon.toSvgImg(
          Theme.of(context).colorScheme.primary,
          BaseUtility.iconNormalSize,
          BaseUtility.iconNormalSize,
        ),
      ),
    );
  }
}
