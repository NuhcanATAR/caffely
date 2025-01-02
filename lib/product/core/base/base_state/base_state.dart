import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/shared_service.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  // dynamic extensions
  DynamicViewExtensions dynamicViewExtensions = DynamicViewExtensions();

  // logger
  final loggerPrint = CustomLoggerPrint();

  final prefService = PrefService();

  Future<UserModel> getUserFromFireStore(String authID) async {
    final DocumentSnapshot snapshotData =
        await FirebaseCollectionReferances.users.collectRef.doc(authID).get();
    if (snapshotData.exists) {
      final Map<String, dynamic> data =
          snapshotData.data() as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } else {
      return UserModel(
        '',
        '',
        '',
        '',
        '',
        0,
        '',
        '',
        0,
      );
    }
  }
}
