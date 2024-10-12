import 'package:caffely/feature/account/view/personal_information/bloc/event.dart';
import 'package:caffely/feature/account/view/personal_information/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInformationBloc
    extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  PersonalInformationBloc() : super(PersonalInformationState()) {
    on<PersonalInformationUpdatedEvent>(personalInformationUpdate);
  }

  Future<void> personalInformationUpdate(
    PersonalInformationUpdatedEvent event,
    Emitter<PersonalInformationState> emit,
  ) async {
    emit(PersonalInformationUpdateLoading());
    try {
      await FirebaseCollectionReferances.users.collectRef
          .doc(FirebaseService().authID)
          .update({
        'name_surname': event.nameSurmame,
        'phone_number': event.phoneNumber,
        'city': event.selectedCity,
        'district': event.selectedDistrict,
      });
      if (!event.context.mounted) return;
      emit(
        PersonalInformationUpdateSuccess(
          AppLocalizations.of(event.context)!
              .account_personal_information_success,
        ),
      );
    } catch (e) {
      if (!event.context.mounted) return;
      emit(
        PersonalInformationUpdateError(
          AppLocalizations.of(event.context)!
              .account_personal_information_error,
        ),
      );
    }
  }
}
