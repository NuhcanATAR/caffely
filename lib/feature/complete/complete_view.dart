import 'package:flutter/material.dart';

class ProfileCompleteView extends StatefulWidget {
  const ProfileCompleteView({super.key});

  @override
  State<ProfileCompleteView> createState() => _ProfileCompleteViewState();
}

class _ProfileCompleteViewState extends State<ProfileCompleteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: true,
      ),
    );
  }
}
