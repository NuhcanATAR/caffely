import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class LanguageCardWidget extends StatelessWidget {
  const LanguageCardWidget({
    super.key,
    required this.menuText,
    required this.groupValue,
    required this.onChanged,
    required this.flagIcon,
    required this.onTap,
    required this.value,
  });

  final String menuText;
  final String? groupValue;
  final Function(String?)? onChanged;
  final AppImages flagIcon;
  final Function() onTap;
  final String value;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: BaseUtility.all(
        BaseUtility.paddingNormalValue,
      ),
      title: BodyMediumBlackText(
        text: menuText,
        textAlign: TextAlign.left,
      ),
      leading: Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      trailing: flagIcon.toPngImg(
        30,
        30,
      ),
      onTap: () => onTap,
    );
  }
}
