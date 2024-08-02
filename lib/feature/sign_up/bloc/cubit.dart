import 'package:caffely/feature/sign_up/bloc/event.dart';
import 'package:caffely/feature/sign_up/bloc/state.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          .set({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'name_surname': '',
        'email': event.email,
        'password': event.password,
        'phone_number': 0,
        'city': '',
        'district': '',
        'auth_status': 1,
        'date': FieldValue.serverTimestamp(),
      });

      final User? userAuth = userCredential.user;
      await userAuth?.sendEmailVerification();

      emit(
        const SignUpSuccessState(
          'Hesabınız Başarıyla oluşturuldu!',
        ),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          emit(const SignUpErrorState('E-mail adresi zaten kullanımda.'));
        } else {
          emit(const SignUpErrorState('Kayıt işlemi başarısız oldu.'));
        }
      } else {
        emit(const SignUpErrorState('Kayıt işlemi başarısız oldu'));
      }
    }
  }
}
