import 'package:caffely/feature/account/view/about_app/about_app_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/social_media_button_widget.dart';
import 'package:flutter/material.dart';

class AboutAppView extends StatefulWidget {
  const AboutAppView({super.key});

  @override
  State<AboutAppView> createState() => _AboutAppViewState();
}

class _AboutAppViewState extends AboutAppViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: AppIcons.arrowLeft.toSvgImg(
            Colors.black,
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.account_aboutapp_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        child: ListView(
          children: <Widget>[
            // logo
            buildLogoWidget,
            // title & explanation
            buildTitleExplanationWidget,
            // social media buttons
            buildSocialMediaButtonsWidget,
          ],
        ),
      ),
    );
  }

  // logo
  Widget get buildLogoWidget => SizedBox(
        height: dynamicViewExtensions.dynamicHeight(context, 0.13),
        child: AppLogoConstants.appLogoNoBackgroundColorPrimary.toImg,
      );

  // title & explanation
  Widget get buildTitleExplanationWidget => Column(
        children: <Widget>[
          // title
          Padding(
            padding: BaseUtility.vertical(
              BaseUtility.paddingNormalValue,
            ),
            child: TitleLargeBlackBoldText(
              text: title,
              textAlign: TextAlign.center,
            ),
          ),
          // explanation
          Padding(
            padding: BaseUtility.vertical(
              BaseUtility.paddingMediumValue,
            ),
            child: BodyMediumBlackText(
              text: explanation,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  // social media buttons
  Widget get buildSocialMediaButtonsWidget => Row(
        children: <Widget>[
          // github
          SocialMediaButtonWidget(
            onTap: () {
              linkOpen(githubUrl);
            },
            color: Colors.black,
            icon: AppIcons.github,
            btnText: 'Github',
          ),
          const Spacer(),
          // linkedin
          SocialMediaButtonWidget(
            onTap: () {
              linkOpen(linkedinUrl);
            },
            color: Colors.blue,
            icon: AppIcons.linkedin,
            btnText: 'Linkedin',
          ),
        ],
      );
}
