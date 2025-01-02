import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/validator/custom_validator.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomPasswordFieldWidget extends StatefulWidget {
  const CustomPasswordFieldWidget({
    super.key,
    required this.passwordController,
    required this.hintText,
    required this.onChanged,
    required this.isValidator,
    required this.isLabelText,
  });

  final TextEditingController passwordController;
  final String hintText;
  final Function(String)? onChanged;
  final bool isValidator;
  final bool isLabelText;

  @override
  State<CustomPasswordFieldWidget> createState() =>
      _CustomPasswordFieldWidgetState();
}

class _CustomPasswordFieldWidgetState
    extends BaseState<CustomPasswordFieldWidget> {
  String? errorText;
  late bool isPassObscured = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // label text
        buildLabelTextWidget,
        // password field
        buildPasswordFieldWidget,
        // validator error
        if (errorText != null) buildValidatorErrorWidget,
      ],
    );
  }

  // label text
  Widget get buildLabelTextWidget => widget.isLabelText == true
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
      : const SizedBox();

  // password field
  Widget get buildPasswordFieldWidget => Container(
        margin: widget.isLabelText == true
            ? const EdgeInsets.only(
                left: BaseUtility.marginNormalValue,
                bottom: BaseUtility.marginNormalValue,
              )
            : context.padding.onlyBottomLow,
        child: TextFormField(
          obscureText: isPassObscured,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.scrim,
                fontWeight: FontWeight.bold,
              ),
          controller: widget.passwordController,
          validator: widget.isValidator == true
              ? (String? value) =>
                  CustomValidator(value: value, context: context).passwordCheck
              : (String? value) =>
                  CustomValidator(value: value, context: context)
                      .emptyNormalCheck,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPassObscured = !isPassObscured;
                });
              },
              icon: isPassObscured == true
                  ? AppIcons.eyeOutline.toSvgImg(
                      Colors.black,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    )
                  : AppIcons.eyeCloseOutline.toSvgImg(
                      Colors.black,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    ),
            ),
            icon: AppIcons.lockFill.toSvgImg(
              Colors.black,
              BaseUtility.iconNormalSize,
              BaseUtility.iconNormalSize,
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
      );

  // validator error
  Widget get buildValidatorErrorWidget => Padding(
        padding: BaseUtility.vertical(
          BaseUtility.paddingMediumValue,
        ),
        child: Row(
          children: [
            AppIcons.warningCircle.toSvgImg(
              Theme.of(context).colorScheme.error,
              BaseUtility.iconSmallSize,
              BaseUtility.iconSmallSize,
            ),
            Expanded(
              child: Padding(
                padding: BaseUtility.left(
                  BaseUtility.paddingSmallValue,
                ),
                child: BodyMediumRedText(
                  text: errorText!,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      );
}
