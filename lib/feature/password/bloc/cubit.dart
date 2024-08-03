import 'package:caffely/feature/password/bloc/event.dart';
import 'package:caffely/feature/password/bloc/state.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordState()) {
    on<PasswordEmailEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordResetEvent>(resetPassword);
  }

  Future<void> resetPassword(
    PasswordResetEvent event,
    Emitter<PasswordState> emit,
  ) async {
    emit(PasswordLoadingState(event.dynamicViewExtensions));
    try {
      final userCollection = await FirebaseCollectionReferances.users.collectRef
          .where('email', isEqualTo: event.email)
          .get();

      if (userCollection.docs.isNotEmpty) {
        await FirebaseService().authService.sendPasswordResetEmail(
              email: event.email,
            );
        emit(
          const PasswordSuccessState(
            'E-mail adresinize şifre yenileme maili gönderildi.',
          ),
        );
      } else {
        emit(
          const PasswordErrorState(
            'E-mail adresi bulunamadı, lütfen e-mail adresinizi kontrol ediniz.',
          ),
        );
      }
    } catch (e) {
      emit(
        const PasswordErrorState(
          'E-mail adresi bulunamadı, lütfen e-mail adresinizi kontrol ediniz.',
        ),
      );
    }
  }
}
