// ignore_for_file: avoid_dynamic_calls, unawaited_futures, use_build_context_synchronously

import 'dart:async';

import 'package:caffely/feature/splash/splash_view.dart';
import 'package:caffely/main.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

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
    final String? userId = await prefService.getString('current_user');

    if (userId!.isEmpty) {
      loggerPrint.printInfoLog('Oturum ID Bulunmuyor Henüz');
    } else {
      loggerPrint.printInfoLog('Bildirim için kullanıcı Oturum ID: $userId');
    }
  }

  Future<void> requestNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      loggerPrint.printInfoLog('Bildirim izni verildi');
    } else if (status.isDenied) {
      loggerPrint.printInfoLog('Bildirim izni reddedildi.');
    }
  }
}
