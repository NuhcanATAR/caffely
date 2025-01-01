// ignore_for_file: deprecated_member_use

import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../product/widget/text_widget/title_large_text.dart';

class VersionView extends StatefulWidget {
  const VersionView({super.key});

  @override
  State<VersionView> createState() => _VersionViewState();
}

class _VersionViewState extends BaseState<VersionView> {
  late String coverImage =
      "https://firebasestorage.googleapis.com/v0/b/caffely-90d9a.appspot.com/o/images%2Fpexels-ron-lach-8429814.jpg?alt=media&token=5c0177f2-45b6-4b92-a582-4b8160056581";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(coverImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      BaseUtility.radiusCircularMediumValue,
                    ),
                    topRight: Radius.circular(
                      BaseUtility.radiusCircularMediumValue,
                    ),
                  ),
                ),
                child: Container(
                  padding: BaseUtility.all(
                    BaseUtility.paddingNormalValue,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        BaseUtility.radiusCircularMediumValue,
                      ),
                      topRight: Radius.circular(
                        BaseUtility.radiusCircularMediumValue,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // icon
                        Container(
                          margin: BaseUtility.bottom(
                            BaseUtility.paddingNormalValue,
                          ),
                          padding: BaseUtility.all(
                            30,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              BaseUtility.radiusCircularHighValue,
                            ),
                          ),
                          child: AppIcons.rocketOutline.toSvgImg(
                            Colors.black,
                            BaseUtility.iconMediumSecondSize,
                            BaseUtility.iconMediumSecondSize,
                          ),
                        ),
                        // title
                        Padding(
                          padding: BaseUtility.vertical(
                            BaseUtility.paddingNormalValue,
                          ),
                          child: TitleLargeBlackBoldText(
                            text: AppLocalizations.of(context)!.version_title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // sub title
                        Padding(
                          padding: BaseUtility.vertical(
                            BaseUtility.paddingNormalValue,
                          ),
                          child: BodyMediumBlackText(
                            text:
                                AppLocalizations.of(context)!.version_subtitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // update button
                        CustomButtonWidget(
                          dynamicViewExtensions: dynamicViewExtensions,
                          text: AppLocalizations.of(context)!.version_btn,
                          func: () async {
                            if (!await launchUrl(
                              Uri.parse(
                                'https://play.google.com/store/apps?hl=tr',
                              ),
                            )) {
                              throw Exception('Could not launch ');
                            }
                          },
                          btnStatus: ButtonTypes.primaryColorButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
