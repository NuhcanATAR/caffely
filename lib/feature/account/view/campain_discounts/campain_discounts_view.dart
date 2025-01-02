import 'package:caffely/feature/account/view/campain_discounts/campain_discounts_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:flutter/material.dart';

class CampainDiscountsView extends StatefulWidget {
  const CampainDiscountsView({super.key});

  @override
  State<CampainDiscountsView> createState() => _CampainDiscountsViewState();
}

// buradan devam et
class _CampainDiscountsViewState extends CampainDiscountsViewModel {
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
      ),
      body: CustomResponseWidget(
        img: AppImages.campaign,
        title: AppLocalizations.of(context)!.account_campaign_discaount_title,
        subTitle:
            AppLocalizations.of(context)!.account_campaign_discaount_subtitle,
      ),
    );
  }
}
