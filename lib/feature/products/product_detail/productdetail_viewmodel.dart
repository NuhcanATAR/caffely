import 'package:caffely/feature/products/product_detail/productdetail_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductDetailViewModel extends BaseState<ProductDetailView> {
  Stream<QuerySnapshot> getFavoriteStream() {
    final userId = FirebaseService().authID;
    return FirebaseCollectionReferances.favorite.collectRef
        .where('user_id', isEqualTo: userId)
        .snapshots();
  }
}
