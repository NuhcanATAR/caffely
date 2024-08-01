import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _authID;

  FirebaseService() {
    _initialize();
  }

  FirebaseFirestore get cloudFireStore => _firestore;

  FirebaseAuth get authService => _auth;

  String? get authID => _authID;

  void _initialize() {
    if (_auth.currentUser != null) {
      _authID = _auth.currentUser!.uid;
    } else {
      _authID = null;
    }
  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
}
