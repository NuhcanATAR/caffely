import 'dart:async';
import 'dart:ui';

import 'package:caffely/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class AppStart {
  const AppStart._();

  static Future<void> initStartApp() async {
    await initializeDateFormatting();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Logger().i('Starting background service initialization');

    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    HydratedBloc.storage = storage;

    // İzinleri kontrol et ve iste
    await _requestPermissions();

    final fcmToken = await FirebaseMessaging.instance.getToken();
    Logger().i('Notification Token ID: $fcmToken');
  }

  static Future<void> _requestPermissions() async {
    // Bildirim izni talep et
    if (await Permission.notification.request().isGranted) {
      Logger().i('Bildirim izni verildi');
    } else {
      Logger().i('Bildirim izni reddedildi');
    }

    // Battery optimizasyon izni talep et
    if (await Permission.ignoreBatteryOptimizations.request().isGranted) {
      Logger().i('Battery optimizasyon izni verildi');
    } else {
      Logger().i('Battery optimizasyon izni reddedildi');
    }
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      autoStartOnBoot: true, // Cihaz yeniden başlatıldığında servisi başlat
      initialNotificationTitle: 'Caffely',
      initialNotificationContent: 'Uygulama şu an çalışıyor',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  final isServiceRunning = await service.isRunning();
  Logger().i('Service running: $isServiceRunning');

  if (!isServiceRunning) {
    await service.startService();
  }
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  Logger().i('iOS background fetch executed');
  return true;
}

Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  Logger().i('Background service onStart executed');

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    await service.setForegroundNotificationInfo(
      title: "Caffely",
      content: "Uygulama arka planda çalışıyor",
    );
  }

  service.on('update').listen((event) {
    Logger().i('Background service update event: $event');
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        await service.setForegroundNotificationInfo(
          title: "E-Çiftçi",
          content: "Uygulama arka planda çalışıyor",
        );
      }
    }

    Logger().i('Background service running...');
    service.invoke('update', {
      "current_date": DateTime.now().toIso8601String(),
    });
  });
}
