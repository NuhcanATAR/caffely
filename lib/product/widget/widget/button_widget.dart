import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../product/util/base_utility.dart';
import '../../../product/widget/text_widget/body_medium_text.dart';

// decoration
// TODO: #1 1 == background color main theme color
// TODO: #2 2 == background color main theme color
// TODO: #3 3 == no background color border main color
// TODO: #4 4 == no background color border error color

// btn inside widget
// TODO: #18 1 == text white center text
// TODO: #19 2 == left ıcon center text
// TODO: #20 3 == text theme main color center text
// TODO: #21 4 == text theme error color center text

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
  final int btnStatus;

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
            padding: PaddingSizedsUtility.horizontal(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            alignment: Alignment.center,
            decoration: btnStatus == 1
                ? BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        RadiusUtility.circularMediumValue,
                      ),
                    ),
                  )
                : btnStatus == 2
                    ? BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            RadiusUtility.circularMediumValue,
                          ),
                        ),
                      )
                    : btnStatus == 3
                        ? BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                RadiusUtility.circularMediumValue,
                              ),
                            ),
                          )
                        : BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.error,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                RadiusUtility.circularMediumValue,
                              ),
                            ),
                          ),
            child: btnStatus == 1
                ? BodyMediumWhiteText(
                    text: text,
                    textAlign: TextAlign.center,
                  )
                : btnStatus == 2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AppIcons.add.toSvgImg(
                            Colors.white,
                            IconSizedsUtility.normalSize,
                            IconSizedsUtility.normalSize,
                          ),
                          Expanded(
                            child: BodyMediumWhiteText(
                              text: text,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : btnStatus == 3
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
