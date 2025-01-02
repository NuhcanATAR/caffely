import 'package:animate_do/animate_do.dart';
import 'package:caffely/feature/bottom_menu/bottom_menu_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';

class CompleteSuccessView extends StatefulWidget {
  const CompleteSuccessView({super.key});

  @override
  State<CompleteSuccessView> createState() => _CompleteSuccessViewState();
}

class _CompleteSuccessViewState extends BaseState<CompleteSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: Padding(
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        child: Column(
          children: <Widget>[
            // body
            buildBodyWidget,
            // footer button
            buildFooterButtonWidget,
          ],
        ),
      ),
    );
  }

  // body
  Widget get buildBodyWidget => Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInDown(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Container(
                    margin: BaseUtility.all(
                      BaseUtility.marginNormalValue,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          BaseUtility.radiusCircularHighValue,
                        ),
                      ),
                    ),
                    child: AppIcons.doneOutline.toSvgImg(
                      Colors.white,
                      BaseUtility.iconLargeSecondSize,
                      BaseUtility.iconLargeSecondSize,
                    ),
                  ),
                ),
              ),
              FadeInUp(
                child: Padding(
                  padding: BaseUtility.vertical(
                    BaseUtility.paddingNormalValue,
                  ),
                  child: TitleLargeBlackBoldText(
                    text: AppLocalizations.of(context)!
                        .sign_complete_success_title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FadeInUp(
                child: Padding(
                  padding: BaseUtility.bottom(
                    BaseUtility.paddingNormalValue,
                  ),
                  child: BodyMediumBlackText(
                    text: AppLocalizations.of(context)!
                        .sign_complete_success_subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // footer button
  Widget get buildFooterButtonWidget => FadeInUp(
        child: CustomButtonWidget(
          dynamicViewExtensions: dynamicViewExtensions,
          text: AppLocalizations.of(context)!.sign_complete_start_btn,
          func: () {
            CodeNoahNavigatorRouter.pushAndRemoveUntil(
              context,
              const BottomMenuView(),
              direction: SlideDirection.rightToLeft,
            );
          },
          btnStatus: ButtonTypes.primaryColorButton,
        ),
      );
}
