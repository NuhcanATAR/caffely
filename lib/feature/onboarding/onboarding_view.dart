import 'package:animate_do/animate_do.dart';
import 'package:caffely/feature/onboarding/onboarding_viewmodel.dart';
import 'package:caffely/feature/sign/sign_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/onboarding_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends OnBoardingViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 5,
                ),
              ),
            ),
          ),
          // top
          buildTopWidget(),
          // body
          buildBodyWidget(),
          // status bar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildStepIndicator(
                context,
                selectProccessIndex >= StepProccess.oneView.value ? 25 : 8,
                selectProccessIndex >= StepProccess.oneView.value
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              _buildStepIndicator(
                context,
                selectProccessIndex >= StepProccess.secondView.value ? 25 : 8,
                selectProccessIndex >= StepProccess.secondView.value
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              _buildStepIndicator(
                context,
                selectProccessIndex >= StepProccess.threeView.value ? 25 : 8,
                selectProccessIndex >= StepProccess.threeView.value
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
            ],
          ),
          // footer
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingMediumValue,
              ),
              child: Row(
                children: <Widget>[
                  // skip
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FadeInLeft(
                      child: Padding(
                        padding: BaseUtility.horizontal(
                          BaseUtility.paddingNormalValue,
                        ),
                        child: CustomButtonWidget(
                          dynamicViewExtensions: dynamicViewExtensions,
                          text: selectProccessIndex >=
                                  StepProccess.secondView.value
                              ? AppLocalizations.of(context)!
                                  .onboarding_previous_btn
                              : AppLocalizations.of(context)!
                                  .onboarding_late_btn,
                          func: () {
                            if (selectProccessIndex ==
                                StepProccess.oneView.value) {
                              CodeNoahNavigatorRouter.pushAndRemoveUntil(
                                context,
                                const SignView(),
                                direction: SlideDirection.rightToLeft,
                              );
                            } else if (selectProccessIndex ==
                                StepProccess.secondView.value) {
                              setState(() {
                                selectProccessIndex =
                                    StepProccess.oneView.value;
                              });
                            } else if (selectProccessIndex ==
                                StepProccess.threeView.value) {
                              setState(() {
                                selectProccessIndex =
                                    StepProccess.secondView.value;
                              });
                            }
                          },
                          btnStatus: ButtonTypes.borderPrimaryColorButton,
                        ),
                      ),
                    ),
                  ),
                  // continue
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FadeInRight(
                      child: Padding(
                        padding: BaseUtility.horizontal(
                          BaseUtility.paddingNormalValue,
                        ),
                        child: CustomButtonWidget(
                          dynamicViewExtensions: dynamicViewExtensions,
                          text: selectProccessIndex ==
                                  StepProccess.threeView.value
                              ? AppLocalizations.of(context)!
                                  .onboarding_start_btn
                              : AppLocalizations.of(context)!
                                  .onboarding_continue,
                          func: () {
                            if (selectProccessIndex ==
                                StepProccess.oneView.value) {
                              setState(() {
                                selectProccessIndex =
                                    StepProccess.secondView.value;
                              });
                            } else if (selectProccessIndex ==
                                StepProccess.secondView.value) {
                              setState(() {
                                selectProccessIndex =
                                    StepProccess.threeView.value;
                              });
                            } else if (selectProccessIndex ==
                                StepProccess.threeView.value) {
                              CodeNoahNavigatorRouter.pushAndRemoveUntil(
                                context,
                                const SignView(),
                                direction: SlideDirection.rightToLeft,
                              );
                            }
                          },
                          btnStatus: ButtonTypes.primaryColorButton,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopWidget() {
    if (selectProccessIndex >= StepProccess.oneView.value &&
        selectProccessIndex < onBoardingImage.length) {
      return Expanded(
        flex: 6,
        child: onBoardingImage[selectProccessIndex],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildBodyWidget() {
    if (selectProccessIndex >= StepProccess.oneView.value &&
        selectProccessIndex < onBoardingText.length) {
      return Flexible(
        fit: FlexFit.tight,
        flex: 2,
        child: Padding(
          padding: BaseUtility.all(
            BaseUtility.paddingNormalValue,
          ),
          child: onBoardingText[selectProccessIndex],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildStepIndicator(BuildContext context, double width, Color color) {
    return AnimatedContainer(
      width: width,
      height: 8,
      margin: BaseUtility.horizontal(
        BaseUtility.paddingSmallValue,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(BaseUtility.radiusCircularMediumValue),
        ),
      ),
      duration: const Duration(milliseconds: 300), // Animasyon süresi
      curve: Curves.easeInOut, // Animasyon eğrisi
    );
  }
}
