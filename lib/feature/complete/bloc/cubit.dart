import 'package:caffely/feature/complete/bloc/event.dart';
import 'package:caffely/feature/complete/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCompleteBloc
    extends Bloc<ProfileCompleteEvent, ProfileCompleteState> {
  ProfileCompleteBloc() : super(const ProfileCompleteState()) {
    on<ProfileCompleteNameSurnameEvent>((event, emit) {
      emit(state.copyWith(nameSurname: event.nameSurname));
    });

    on<ProfileCompletePhoneNumberEvent>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    });

    on<ProfileCompleteUser>(profileComplete);
  }

  Future<void> profileComplete(
    ProfileCompleteUser event,
    Emitter<ProfileCompleteState> emit,
  ) async {
    emit(
      ProfileCompleteLoading(
        event.dynamicViewExtensions,
      ),
    );
    try {
      await FirebaseCollectionReferances.users.collectRef
          .doc(FirebaseService().authID)
          .update({
        'name_surname': event.nameSurname,
        'phone_number': event.phoneNumber,
        'city': event.city,
        'district': event.district,
      });
      emit(ProfileCompleteSuccess());
    } catch (e) {
      if (!event.context.mounted) return;
      emit(
        ProfileCompleteError(
          AppLocalizations.of(event.context)!.sign_complete_error,
        ),
      );
    }
  }
}
