import 'package:caffely/feature/orders/bloc/event.dart';
import 'package:caffely/feature/orders/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/database/firebase_constant.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/order_model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final loggerPrint = CustomLoggerPrint();
  OrderBloc() : super(OrderInitial()) {
    on<LoadOrderEvent>(_onOrderAll);

    on<LoadBranchesEvent>(_onOrderBranchAll);
  }

  Future<void> _onOrderAll(
    LoadOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final QuerySnapshot snapshot = await FirebaseCollectionReferances
          .orders.collectRef
          .where(FirebaseConstant.userId, isEqualTo: FirebaseService().authID)
          .get();

      final List<OrderModel> orders = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      emit(
        OrderLoaded(
          orders: orders,
        ),
      );
    } catch (e) {
      if (!event.context.mounted) return;
      emit(
        OrderError(AppLocalizations.of(event.context)!.order_error),
      );
      loggerPrint.printErrorLog(e.toString());
    }
  }

  Future<void> _onOrderBranchAll(
    LoadBranchesEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final QuerySnapshot snapshot = await FirebaseCollectionReferances
          .orders.collectRef
          .doc(event.orderId)
          .collection(FirebaseCollectionReferances.basket.name)
          .doc(event.orderId)
          .collection(FirebaseCollectionReferances.branch.name)
          .get();

      final List<BasketBranchModel> branches = snapshot.docs
          .map(
            (doc) =>
                BasketBranchModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      int totalPrice = 0;
      int totalQuanity = 0;

      for (final branch in branches) {
        totalPrice += branch.basketTotal;
        totalQuanity += branch.totalQuanity;
      }

      final QuerySnapshot orderSnapshot = await FirebaseCollectionReferances
          .orders.collectRef
          .where(FirebaseConstant.userId, isEqualTo: FirebaseService().authID)
          .get();

      final List<OrderModel> orders = orderSnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      emit(
        OrderLoaded(
          orders: orders,
          branches: branches,
          totalPrice: totalPrice,
          totalQuanity: totalQuanity,
        ),
      );
    } catch (e) {
      if (!event.context.mounted) return;
      emit(OrderError(AppLocalizations.of(event.context)!.order_error));
      loggerPrint.printErrorLog(e.toString());
    }
  }
}
