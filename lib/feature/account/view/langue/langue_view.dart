// ignore_for_file: use_build_context_synchronously

import 'package:caffely/feature/account/view/langue/langue_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/model/langue_model/langue_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/language_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LangueView extends StatefulWidget {
  const LangueView({super.key});

  @override
  State<LangueView> createState() => _LangueViewState();
}

class _LangueViewState extends LangueViewModel {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

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
          text: AppLocalizations.of(context)!.account_langue_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: BaseUtility.all(
          BaseUtility.paddingSmallValue,
        ),
        child: Column(
          children: <Widget>[
            // body
            buildBodyWidget(languageProvider),
          ],
        ),
      ),
    );
  }

  // body
  Widget buildBodyWidget(LanguageProvider languageProvider) => // body
      Expanded(
        child: ListView(
          children: <Widget>[
            // english
            LanguageCardWidget(
              menuText: 'English',
              value: 'en',
              groupValue: languageProvider.selectedLanguage,
              onChanged: (value) {
                setState(() {
                  languageProvider.setLanguage(value!);
                });
              },
              flagIcon: AppImages.flagEnglish,
              onTap: () => saveLanguage('en'),
            ),
            // turkish
            LanguageCardWidget(
              menuText: 'Türkçe',
              value: 'tr',
              groupValue: languageProvider.selectedLanguage,
              onChanged: (value) {
                setState(() {
                  languageProvider.setLanguage(value!);
                });
              },
              flagIcon: AppImages.flagTurkey,
              onTap: () => saveLanguage('tr'),
            ),
          ],
        ),
      );
}
