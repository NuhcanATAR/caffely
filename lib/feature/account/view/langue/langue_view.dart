// ignore_for_file: use_build_context_synchronously

import 'package:caffely/feature/account/view/langue/langue_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/model/langue_model/langue_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
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
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Dil Seçimi',
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.smallPaddingValue,
        ),
        child: Column(
          children: <Widget>[
            // body
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    contentPadding: PaddingSizedsUtility.all(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    title: const BodyMediumBlackText(
                      text: 'English',
                      textAlign: TextAlign.left,
                    ),
                    leading: Radio<String>(
                      value: 'en',
                      groupValue: languageProvider.selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          languageProvider.setLanguage(value!);
                        });
                      },
                    ),
                    trailing: AppImages.flagEnglish.toPngImg(
                      30,
                      30,
                    ),
                    onTap: () => saveLanguage('en'),
                  ),
                  ListTile(
                    title: const Text('Türkçe'),
                    leading: Radio<String>(
                      value: 'tr',
                      groupValue: languageProvider.selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          languageProvider.setLanguage(value!);
                        });
                      },
                    ),
                    trailing: AppImages.flagTurkey.toPngImg(
                      30,
                      30,
                    ),
                    onTap: () => saveLanguage('tr'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
