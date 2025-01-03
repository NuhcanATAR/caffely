import 'package:caffely/feature/sign_up/bloc/event.dart';
import 'package:caffely/feature/sign_up/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpEmailEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignUpPasswordEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignUpUserEvent>(signUp);
  }

  Future<void> signUp(
    SignUpUserEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoadingState());
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      await FirebaseCollectionReferances.users.collectRef
          .doc(FirebaseService().authID)
          .set(
            UserModel(
              id: FirebaseAuth.instance.currentUser!.uid,
              profileImage: '',
              nameSurname: '',
              email: event.email,
              phoneNumber: 0,
              city: '',
              district: '',
              authStatus: 1,
            ).toUserInformationSet(password: event.password),
          );

      final User? userAuth = userCredential.user;
      await userAuth?.sendEmailVerification();
      if (!event.context.mounted) return;
      emit(
        SignUpSuccessState(
          AppLocalizations.of(event.context)!.signup_success,
        ),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          emit(
            SignUpErrorState(
              AppLocalizations.of(event.context)!.signup_email_already_in_use,
            ),
          );
        } else {
          emit(
            SignUpErrorState(
              AppLocalizations.of(event.context)!.signup_email_erorr,
            ),
          );
        }
      } else {
        emit(
          SignUpErrorState(AppLocalizations.of(event.context)!.signup_error),
        );
      }
    }
  }
}
