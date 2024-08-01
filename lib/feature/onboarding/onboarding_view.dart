import 'package:animate_do/animate_do.dart';
import 'package:caffely/feature/onboarding/onboarding_viewmodel.dart';
import 'package:caffely/feature/sign/sign_view.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/onboarding_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
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
                      : Colors.grey),
              _buildStepIndicator(
                  context,
                  selectProccessIndex >= StepProccess.secondView.value ? 25 : 8,
                  selectProccessIndex >= StepProccess.secondView.value
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey),
              _buildStepIndicator(
                  context,
                  selectProccessIndex >= StepProccess.threeView.value ? 25 : 8,
                  selectProccessIndex >= StepProccess.threeView.value
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey),
            ],
          ),
          // footer
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.mediumPaddingValue,
              ),
              child: Row(
                children: <Widget>[
                  // skip
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FadeInLeft(
                      child: Padding(
                        padding: PaddingSizedsUtility.horizontal(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: CustomButtonWidget(
                          dynamicViewExtensions: dynamicViewExtensions,
                          text: selectProccessIndex >=
                                  StepProccess.secondView.value
                              ? 'Geri'
                              : 'Geç',
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
                          btnStatus: 3,
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
                        padding: PaddingSizedsUtility.horizontal(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: CustomButtonWidget(
                          dynamicViewExtensions: dynamicViewExtensions,
                          text: selectProccessIndex ==
                                  StepProccess.threeView.value
                              ? 'Başla'
                              : 'Devam et',
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
                          btnStatus: 1,
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
      return const Center(
        child: BodyMediumBlackText(
          text: 'Seçim Yok',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget buildBodyWidget() {
    if (selectProccessIndex >= StepProccess.oneView.value &&
        selectProccessIndex < onBoardingText.length) {
      return Flexible(
        fit: FlexFit.tight,
        flex: 2,
        child: Padding(
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.normalPaddingValue,
          ),
          child: onBoardingText[selectProccessIndex],
        ),
      );
    } else {
      return const Center(
        child: BodyMediumBlackText(
          text: 'Seçim Yok',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget _buildStepIndicator(BuildContext context, double width, Color color) {
    return AnimatedContainer(
      width: width,
      height: 8,
      margin: PaddingSizedsUtility.horizontal(
          PaddingSizedsUtility.smallPaddingValue),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(RadiusUtility.circularMediumValue),
        ),
      ),
      duration: const Duration(milliseconds: 300), // Animasyon süresi
      curve: Curves.easeInOut, // Animasyon eğrisi
    );
  }
}
