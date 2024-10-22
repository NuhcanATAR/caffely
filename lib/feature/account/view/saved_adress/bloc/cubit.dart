import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAdressBloc extends Bloc<SavedAdressEvent, SavedAdressState> {
  SavedAdressBloc() : super(const SavedAdressState()) {
    on<SavedAdressTitleEvent>((event, emit) {
      emit(state.copyWith(adressTitle: event.title));
    });

    on<SavedAdressCityEvent>((event, emit) {
      emit(state.copyWith(adressCity: event.city));
    });

    on<SavedAdressDistrictEvent>((event, emit) {
      emit(state.copyWith(adressDistrict: event.district));
    });

    on<SavedAdressStreetEvent>((event, emit) {
      emit(state.copyWith(adressStreet: event.street));
    });

    on<SavedAdressFloorEvent>((event, emit) {
      emit(state.copyWith(adressFloor: event.floor));
    });

    on<SavedAdressApartmentNoEvent>((event, emit) {
      emit(state.copyWith(adressAparmentNo: event.apartmentNo));
    });

    on<SavedAdressDirectionsEvent>((event, emit) {
      emit(state.copyWith(adressDirections: event.directions));
    });

    on<SavedAdressContactNameEvent>((event, emit) {
      emit(state.copyWith(contactName: event.contactName));
    });

    on<SavedAdressContactSurnameEvent>((event, emit) {
      emit(state.copyWith(contactSurname: event.contactSurname));
    });

    on<SavedAdressContactPhoneNumberEvent>((event, emit) {
      emit(state.copyWith(contactPhoneNumber: event.contactPhoneNumber));
    });

    on<LoadSavedAdressEvent>(_onLoadSavedAdress);

    on<SaveAdressCreateEvent>(savedAdressCreate);

    on<SaveAdressEditEvent>(saveAdressEdit);

    on<SaveAdressDeleteEvent>(saveAdressDelete);
  }

  Future<void> _onLoadSavedAdress(
    LoadSavedAdressEvent event,
    Emitter<SavedAdressState> emit,
  ) async {
    emit(SavedAdressLoading());
    try {
      final QuerySnapshot snapshot = await FirebaseCollectionReferances
          .saved_adress.collectRef
          .where('is_deleted', isEqualTo: false)
          .where('user_id', isEqualTo: FirebaseService().authID)
          .orderBy('created_date', descending: true)
          .get();

      final List<SavedAdressModel> savedAdress = snapshot.docs
          .map(
            (doc) =>
                SavedAdressModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      emit(SavedAdressLoaded(savedAdress));
    } catch (e) {
      if (!event.context.mounted) return;
      emit(
        SavedAdressError(
          AppLocalizations.of(event.context)!.account_saveadress_load_error,
        ),
      );
    }
  }

  Future<void> savedAdressCreate(
    SaveAdressCreateEvent event,
    Emitter<SavedAdressState> emit,
  ) async {
    emit(SavedAdressLoading());
    try {
      await FirebaseCollectionReferances.saved_adress.collectRef.add({
        'id': null,
        'user_id': FirebaseService().authID,
        'adress_title': event.adressTitle,
        'adress_city': event.adressCity,
        'adress_district': event.adressDistrict,
        'adress_street': event.adressStreet,
        'adress_floor': event.adressFloor,
        'adress_apartment_no': event.adressAparmentNo,
        'adress_directions': event.adressDirections,
        'contact_name': event.contactName,
        'contact_surname': event.contactSurname,
        'contact_phone_number': event.contactPhoneNumber,
        'is_deleted': false,
        'created_date': FieldValue.serverTimestamp(),
      }).then((value) {
        final String docId = value.id;
        value.update({'id': docId});
      });
      if (!event.context.mounted) return;
      emit(
        SaveAdressCreateSuccess(
          AppLocalizations.of(event.context)!
              .account_saveadress_create_succcess,
        ),
      );
    } catch (e) {
      emit(
        SaveAdressCreateError(
          AppLocalizations.of(event.context)!.account_saveadress_create_error,
        ),
      );
    }
  }

  Future<void> saveAdressDelete(
    SaveAdressDeleteEvent event,
    Emitter<SavedAdressState> emit,
  ) async {
    try {
      await FirebaseCollectionReferances.saved_adress.collectRef
          .doc(event.model.id)
          .update({
        'is_deleted': true,
      });
      if (!event.context.mounted) return;
      emit(
        SaveAdressDeleteSuccess(
          AppLocalizations.of(event.context)!.account_saveadress_delete_success,
        ),
      );
    } catch (e) {
      emit(
        SaveAdressDeleteError(
          AppLocalizations.of(event.context)!.account_saveadress_delete_error,
        ),
      );
    }
  }

  Future<void> saveAdressEdit(
    SaveAdressEditEvent event,
    Emitter<SavedAdressState> emit,
  ) async {
    emit(SaveAdressUpdateLoading());
    try {
      await FirebaseCollectionReferances.saved_adress.collectRef
          .doc(event.model.id)
          .update({
        'adress_title': event.adressTitle,
        'adress_city': event.adressCity,
        'adress_district': event.adressDistrict,
        'adress_street': event.adressStreet,
        'adress_floor': event.adressFloor,
        'adress_apartment_no': event.adressAparmentNo,
        'adress_directions': event.adressDirections,
        'contact_name': event.contactName,
        'contact_surname': event.contactSurname,
        'contact_phone_number': event.contactPhoneNumber,
      });
      if (!event.context.mounted) return;
      emit(
        SaveAdressUpdateSuccess(
          AppLocalizations.of(event.context)!.account_saveadress_edit_success,
        ),
      );
    } catch (e) {
      emit(
        SaveAdressUpdateError(
          AppLocalizations.of(event.context)!.account_saveadress_edit_error,
        ),
      );
    }
  }
}
