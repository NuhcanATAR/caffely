import 'package:caffely/feature/account/view/campain_discounts/campaindiscounts_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:flutter/material.dart';

class CampainDiscountsView extends StatefulWidget {
  const CampainDiscountsView({super.key});

  @override
  State<CampainDiscountsView> createState() => _CampainDiscountsViewState();
}

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
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Kampanya ve İndirimler',
          textAlign: TextAlign.left,
        ),
      ),
      body: const CustomResponseWidget(
        img: AppImages.campaign,
        title: 'Henüz kampanya ve indirim bulunmuyor.',
        subTitle:
            'Kampanya ve indirimler henüz gelmedi çok yakında buradan paylaşım yapılacak.',
      ),
    );
  }
}
