import 'package:caffely/feature/account/view/personal_information/bloc/event.dart';
import 'package:caffely/feature/account/view/personal_information/bloc/state.dart';
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
      emit(
        PersonalInformationUpdateSuccess(
          'Profil bilgileri başarıyla güncellendi!',
        ),
      );
    } catch (e) {
      emit(
        PersonalInformationUpdateError(
          'Profil bilgileri güncellenirken bir hata oluştu, lütfen daha sonra tekrar deneyiniz.',
        ),
      );
    }
  }
}
