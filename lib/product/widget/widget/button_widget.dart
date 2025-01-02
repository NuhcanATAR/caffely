import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../product/util/base_utility.dart';
import '../../../product/widget/text_widget/body_medium_text.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.text,
    required this.func,
    required this.btnStatus,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final String text;
  final Function()? func;
  final ButtonTypes btnStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopNormal,
      child: GestureDetector(
        onTap: func,
        child: SizedBox(
          width: dynamicViewExtensions.maxWidth(context),
          height: dynamicViewExtensions.dynamicHeight(context, 0.06),
          child: Container(
            padding: BaseUtility.horizontal(
              BaseUtility.paddingNormalValue,
            ),
            alignment: Alignment.center,
            decoration: btnStatus.buttonTypeValue ==
                    ButtonTypes.primaryColorButton.buttonTypeValue
                ? BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        BaseUtility.radiusCircularMediumValue,
                      ),
                    ),
                  )
                : btnStatus.buttonTypeValue ==
                        ButtonTypes.iconPrimaryColorButton.buttonTypeValue
                    ? BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            BaseUtility.radiusCircularMediumValue,
                          ),
                        ),
                      )
                    : btnStatus.buttonTypeValue ==
                            ButtonTypes.borderPrimaryColorButton.buttonTypeValue
                        ? BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                BaseUtility.radiusCircularMediumValue,
                              ),
                            ),
                          )
                        : BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.error,
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                BaseUtility.radiusCircularMediumValue,
                              ),
                            ),
                          ),
            child: btnStatus.buttonTypeValue ==
                    ButtonTypes.primaryColorButton.buttonTypeValue
                ? BodyMediumWhiteText(
                    text: text,
                    textAlign: TextAlign.center,
                  )
                : btnStatus.buttonTypeValue ==
                        ButtonTypes.iconPrimaryColorButton.buttonTypeValue
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AppIcons.add.toSvgImg(
                            Colors.white,
                            BaseUtility.iconNormalSize,
                            BaseUtility.iconNormalSize,
                          ),
                          Expanded(
                            child: BodyMediumWhiteText(
                              text: text,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : btnStatus.buttonTypeValue ==
                            ButtonTypes.borderPrimaryColorButton.buttonTypeValue
                        ? BodyMediumMainColorText(
                            text: text,
                            textAlign: TextAlign.center,
                          )
                        : BodyMediumRedText(
                            text: text,
                            textAlign: TextAlign.center,
                          ),
          ),
        ),
      ),
    );
  }
}
