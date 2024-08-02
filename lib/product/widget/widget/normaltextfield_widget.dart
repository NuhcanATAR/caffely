import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/validator/custom_validator.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NormalTextFieldWidget extends StatelessWidget {
  const NormalTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.explanationStatus,
    required this.onChanged,
    required this.isValidator,
    required this.enabled,
    required this.isLabelText,
    required this.dynamicViewExtensions,
  });
  final TextEditingController controller;
  final String hintText;
  final bool explanationStatus;
  final void Function(String)? onChanged;
  final bool isValidator;
  final bool enabled;
  final bool isLabelText;
  final DynamicViewExtensions dynamicViewExtensions;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        isLabelText == true
            ? SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: BodyMediumBlackText(
                    text: hintText,
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          margin: isLabelText == true
              ? EdgeInsets.only(
                  left: MarginSizedsUtility.normalMarginValue,
                  bottom: MarginSizedsUtility.smallMarginValue,
                )
              : context.padding.onlyBottomLow,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily: 'Popins',
                ),
            controller: controller,
            validator: isValidator == true
                ? (String? value) =>
                    CustomValidator(value: value).emptyNormalCheck
                : null,
            onChanged: onChanged,
            keyboardType: TextInputType.emailAddress,
            maxLines: explanationStatus == true ? 4 : null,
            enabled: enabled,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'Popins Light',
                    fontWeight: FontWeight.w500,
                  ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NumberTextFieldWidget extends StatelessWidget {
  const NumberTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.isLabelText,
    required this.dynamicViewExtensions,
  });
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final bool isLabelText;
  final DynamicViewExtensions dynamicViewExtensions;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        isLabelText == true
            ? SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: BodyMediumBlackText(
                    text: hintText,
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
                ),
            onChanged: onChanged,
            controller: controller,
            validator: (String? value) =>
                CustomValidator(value: value).emptyNumberCheck,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'Popins Light',
                    fontWeight: FontWeight.w500,
                  ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
