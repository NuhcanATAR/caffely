// ignore_for_file: deprecated_member_use

import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/validator/custom_validator.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class PhoneNumberFieldWidget extends StatefulWidget {
  const PhoneNumberFieldWidget({
    super.key,
    required this.phoneNumberController,
    required this.hintText,
    required this.onChanged,
    required this.isLabelText,
  });

  final TextEditingController phoneNumberController;
  final String hintText;
  final void Function(String)? onChanged;
  final bool isLabelText;

  @override
  State<PhoneNumberFieldWidget> createState() => _PhoneNumberFieldWidgetState();
}

class _PhoneNumberFieldWidgetState extends BaseState<PhoneNumberFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.isLabelText == true
            ? SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: BaseUtility.vertical(
                    BaseUtility.paddingNormalValue,
                  ),
                  child: BodyMediumBlackText(
                    text: widget.hintText,
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          margin: context.padding.onlyBottomLow,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily: 'Nunito Regular',
                  fontWeight: FontWeight.bold,
                ),
            controller: widget.phoneNumberController,
            validator: (String? value) =>
                CustomValidator(value: value, context: context)
                    .phoneNumberValidator(value),
            onChanged: widget.onChanged,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: BaseUtility.all(
                  BaseUtility.paddingNormalValue,
                ),
                child: AppIcons.callOutline.toSvgImg(
                  Colors.black,
                  BaseUtility.iconNormalSize,
                  BaseUtility.iconNormalSize,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'Popins Light',
                    fontWeight: FontWeight.w500,
                  ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: BaseUtility.paddingNormalValue,
                vertical: BaseUtility.paddingSmallValue,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  BaseUtility.radiusCircularMediumValue,
                ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  BaseUtility.radiusCircularMediumValue,
                ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  BaseUtility.radiusCircularMediumValue,
                ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  BaseUtility.radiusCircularMediumValue,
                ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
