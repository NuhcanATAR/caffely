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
        widget.isLabelText == true
            ? SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: BodyMediumBlackText(
                    text: widget.hintText,
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          margin: widget.isLabelText == true
              ? EdgeInsets.only(
                  left: MarginSizedsUtility.normalMarginValue,
                  bottom: MarginSizedsUtility.smallMarginValue,
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
                ? (String? value) => CustomValidator(value: value).passwordCheck
                : (String? value) =>
                    CustomValidator(value: value).emptyNormalCheck,
            onChanged: widget.onChanged,
            // onChanged: (value) {
            //   setState(() {
            //     errorText = CustomValidator(value: value).passwordCheck;
            //   });
            // },
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
                        IconSizedsUtility.normalSize,
                        IconSizedsUtility.normalSize,
                      )
                    : AppIcons.eyeCloseOutline.toSvgImg(
                        Colors.black,
                        IconSizedsUtility.normalSize,
                        IconSizedsUtility.normalSize,
                      ),
              ),
              icon: AppIcons.lockFill.toSvgImg(
                Colors.black,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: PaddingSizedsUtility.normalPaddingValue,
                vertical: PaddingSizedsUtility.smallPaddingValue,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusUtility.circularMediumValue,
                ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        // validator error
        if (errorText != null)
          Padding(
            padding: PaddingSizedsUtility.vertical(
              PaddingSizedsUtility.mediumPaddingValue,
            ),
            child: Row(
              children: [
                AppIcons.warningCircle.toSvgImg(
                  Theme.of(context).colorScheme.error,
                  IconSizedsUtility.smallSize,
                  IconSizedsUtility.smallSize,
                ),
                Expanded(
                  child: Padding(
                    padding: PaddingSizedsUtility.left(
                      PaddingSizedsUtility.smallPaddingValue,
                    ),
                    child: BodyMediumRedText(
                      text: errorText!,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
