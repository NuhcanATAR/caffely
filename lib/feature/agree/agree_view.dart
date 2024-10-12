import 'package:caffely/feature/agree/agree_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class AgreeView extends StatefulWidget {
  const AgreeView({super.key});

  @override
  State<AgreeView> createState() => _AgreeViewState();
}

class _AgreeViewState extends AgreeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.agreement_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath!,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
