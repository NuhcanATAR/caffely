// ignore_for_file: constant_identifier_names

import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollectionReferances {
  users,
  banners,
  stores,
  product,
  favorite,
  version,
  saved_adress,
  qr_code,
  center_helps,
  basket,
  branch,
  orders;

  CollectionReference get collectRef =>
      FirebaseService().cloudFireStore.collection(name);
}
