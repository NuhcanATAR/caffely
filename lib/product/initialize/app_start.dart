import 'dart:async';

import 'package:caffely/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

@immutable
class AppStart {
  const AppStart._();

  static Future<void> initStartApp() async {
    await initializeDateFormatting();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    HydratedBloc.storage = storage;
  }
}
