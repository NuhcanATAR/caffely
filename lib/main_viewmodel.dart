// ignore_for_file: avoid_dynamic_calls, unawaited_futures, use_build_context_synchronously

import 'dart:async';

import 'package:caffely/feature/splash/splash_view.dart';
import 'package:caffely/main.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MainViewModel extends BaseState<FirsView> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashView()),
      );
    });
  }

  Future<void> getUserId(Timestamp now) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String userId = prefs.getString('current_user') ?? '';

    if (userId.isEmpty) {
      logger.i('Oturum ID Bulunmuyor Henüz');
    } else {
      logger.i('Bildirim için kullanıcı Oturum ID: $userId');
    }
  }

  Future<void> requestNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      logger.i('Bildirim izni verildi');
    } else if (status.isDenied) {
      logger.i('Bildirim izni reddedildi.');
    }
  }
}
