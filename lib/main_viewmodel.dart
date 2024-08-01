// ignore_for_file: avoid_dynamic_calls, unawaited_futures, use_build_context_synchronously

import 'dart:async';

import 'package:caffely/feature/splash/splash_view.dart';
import 'package:caffely/main.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/initialize/app_start.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MainViewModel extends BaseState<FirsView> {
  bool isInitialized = false;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initializeApp();
    requestNotificationPermission();
    backgroundServicePermission();
    startPeriodicService(); // Timer.periodic'i başlatmak için ekledik
  }

  Future<void> initializeApp() async {
    // Add initialization logic here if needed
    // Example: Load initial data, check user authentication, etc.

    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simulating initialization time

    setState(() {
      isInitialized = true;
    });

    // Start background service after initialization
    await initializeService();

    // Yönlendirme işlemi
    if (isInitialized) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashView()),
      );
    }
  }

  void startPeriodicService() {
    Timer.periodic(
      const Duration(minutes: 1),
      (timer) async {
        final now = Timestamp.now();
        Logger().i('Timer tick at ${now.toDate()}');

        try {
          await getUserId(now);
        } catch (e) {
          Logger().e('Error in background service: $e');
        }
      },
    );
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

  Future<void> backgroundServicePermission() async {
    if (await Permission.ignoreBatteryOptimizations.request().isGranted) {
      Logger().i('Battery optimizasyon izni verildi');
    } else {
      Logger().i('Battery optimizasyon izni reddedildi');
    }
  }
}
