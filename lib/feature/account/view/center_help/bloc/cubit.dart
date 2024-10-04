import 'package:caffely/feature/account/view/center_help/bloc/event.dart';
import 'package:caffely/feature/account/view/center_help/bloc/state.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/model/centerhelp_model/centerhelp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CenterHelpBloc extends Bloc<CenterHelpEvent, CenterHelpState> {
  CenterHelpBloc() : super(CenterHelpInitial()) {
    on<LoadCenterHelpEvent>(_onCenterHelpAll);
  }

  Future<void> _onCenterHelpAll(
    LoadCenterHelpEvent event,
    Emitter<CenterHelpState> emit,
  ) async {
    emit(CenterHelpLoading());
    try {
      final QuerySnapshot snapshot = await FirebaseCollectionReferances
          .center_helps.collectRef
          .where('is_deleted', isEqualTo: false)
          .get();

      final List<CenterHelpModel> centerHelps = snapshot.docs
          .map(
            (doc) =>
                CenterHelpModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      emit(
        CenterHelpLoadedState(centerHelps),
      );
    } catch (e) {
      emit(
        CenterHelpError(
          e.toString(),
        ),
      );
    }
  }
}
