import 'package:caffely/feature/account/view/notification/notification_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends NotificationViewModel {
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
          text: 'Bildirim',
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: ListView(
          children: <Widget>[
            // notification card
            buildNotificationCardWidget,
          ],
        ),
      ),
    );
  }

  // notification card
  Widget get buildNotificationCardWidget => ListTile(
        title: const BodyMediumBlackBoldText(
          text: 'Bildirim İzni',
          textAlign: TextAlign.left,
        ),
        subtitle: const BodyMediumBlackText(
          text:
              'Uygulamanın sizlere sipariş durumu hakkında veya iletişim için sizden istediği izin.',
          textAlign: TextAlign.left,
        ),
        trailing: Switch(
          value: notificationEnabled,
          activeColor: Colors.white,
          activeTrackColor: Theme.of(context).colorScheme.primary,
          onChanged: (bool value) {
            if (value) {
              requestPermission(Permission.notification);
            } else {
              showSettingsDialog(
                context,
                dynamicViewExtensions,
              );
            }
          },
        ),
      );
}
