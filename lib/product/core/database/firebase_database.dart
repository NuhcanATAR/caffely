// ignore_for_file: constant_identifier_names

import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollectionReferances {
  users,
  banners,
  stores,
  product,
  version;

  CollectionReference get collectRef =>
      FirebaseService().cloudFireStore.collection(name);
}
