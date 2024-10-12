import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.notification_appbar,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
