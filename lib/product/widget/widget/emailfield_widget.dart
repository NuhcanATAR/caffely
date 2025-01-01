import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/validator/custom_validator.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomEmailFieldWidget extends StatefulWidget {
  const CustomEmailFieldWidget({
    super.key,
    required this.emailController,
    required this.hintText,
    required this.onChanged,
    required this.isLabelText,
  });

  final TextEditingController emailController;
  final String hintText;
  final Function(String)? onChanged;
  final bool isLabelText;

  @override
  State<CustomEmailFieldWidget> createState() => _CustomEmailFieldWidgetState();
}

class _CustomEmailFieldWidgetState extends BaseState<CustomEmailFieldWidget> {
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // email field
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
          margin: widget.isLabelText == true
              ? const EdgeInsets.only(
                  left: BaseUtility.marginNormalValue,
                  bottom: BaseUtility.marginNormalValue,
                )
              : context.padding.onlyBottomLow,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily: 'Popins Light',
                  fontWeight: FontWeight.bold,
                ),
            controller: widget.emailController,
            validator: (String? value) =>
                CustomValidator(value: value, context: context).emailCheck,
            onChanged: widget.onChanged,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              icon: AppIcons.mailFill.toSvgImg(
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

        // validator error
        if (errorText != null)
          Padding(
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
          ),
      ],
    );
  }
}
