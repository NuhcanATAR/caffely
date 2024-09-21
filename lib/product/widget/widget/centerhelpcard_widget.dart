import 'package:caffely/feature/account/view/center_help/view/helpdetail_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/model/centerhelp_model/centerhelp_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class CenterHelpCardWidget extends StatelessWidget {
  const CenterHelpCardWidget({
    super.key,
    required this.helpModel,
  });

  final CenterHelpModel helpModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CodeNoahNavigatorRouter.push(
          context,
          HelpdetailView(
            helpModel: helpModel,
          ),
        );
      },
      child: ListTile(
        title: BodyMediumBlackText(
          text: helpModel.title,
          textAlign: TextAlign.left,
        ),
        trailing: AppIcons.arrowRight.toSvgImg(
          Theme.of(context).colorScheme.primary,
          IconSizedsUtility.normalSize,
          IconSizedsUtility.normalSize,
        ),
      ),
    );
  }
}
