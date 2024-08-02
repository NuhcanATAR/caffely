import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  // dynamic extensions
  DynamicViewExtensions dynamicViewExtensions = DynamicViewExtensions();

  Logger logger = Logger();

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
        0,
        '',
        '',
        0,
      );
    }
  }
}
