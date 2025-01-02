// ignore_for_file: use_build_context_synchronously

import 'package:caffely/feature/sign_in/bloc/event.dart';
import 'package:caffely/feature/sign_in/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/shared_service.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  // logger
  final loggerPrint = CustomLoggerPrint();
  final prefService = PrefService();
  SignInBloc() : super(const SignInState()) {
    on<SignInEmailEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignInPasswordEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignInUserEvent>(signIn);

    on<SignInUserGoogleEvent>(signInWithGoogle);
  }

  Future<void> signIn(
    SignInUserEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoadingState(event.dynamicViewExtensions));
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final User? user = userCredential.user;

      if (user == null) {
        if (!event.context.mounted) return;
        emit(
          SignInErrorState(AppLocalizations.of(event.context)!.sign_error),
        );
      } else {
        if (user.emailVerified) {
          emit(SignInSuccessState(user.uid));
        } else {
          if (!event.context.mounted) return;
          emit(
            SignInErrorState(
              AppLocalizations.of(event.context)!.sign_email_verified_error,
            ),
          );
          await user.sendEmailVerification();
        }
      }
    } on FirebaseAuthException catch (e) {
      if (!event.context.mounted) return;
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage =
              AppLocalizations.of(event.context)!.sign_user_not_found;
          break;
        case 'wrong-password':
          errorMessage =
              AppLocalizations.of(event.context)!.sign_wrong_password;
          break;
        case 'too-many-requests':
          errorMessage =
              AppLocalizations.of(event.context)!.sign_too_many_request;
          break;
        case 'user-disabled':
          errorMessage = AppLocalizations.of(event.context)!.sign_user_disabled;
          break;
        default:
          errorMessage =
              AppLocalizations.of(event.context)!.sign_auth_exception_error;
      }
      loggerPrint
          .printErrorLog('FirebaseAuthException: ${e.code} - ${e.message}');

      await prefService.setBool('remember_me', false);

      emit(SignInErrorState(errorMessage));
    } catch (e) {
      loggerPrint.printErrorLog('Unexpected Error: ${e.toString()}');
      if (!event.context.mounted) return;
      emit(
        SignInErrorState(
          AppLocalizations.of(event.context)!.sign_catch_error,
        ),
      );
    }
  }

  // google sign
  Future<UserCredential?> signInWithGoogle(
    SignInUserGoogleEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      SignInGoogleAuthLoading(
        event.dynamicViewExtensions,
      ),
    );
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        final userCollection = await FirebaseCollectionReferances
            .users.collectRef
            .doc(FirebaseService().authID)
            .get();

        if (userCollection.exists == false) {
          await FirebaseCollectionReferances.users.collectRef
              .doc(FirebaseService().authID)
              .set({
            'id': FirebaseService().authID,
            'profile_image': googleUser.photoUrl,
            'name_surname': '',
            'email': googleUser.email,
            'password': '',
            'phone_number': 0,
            'city': '',
            'district': '',
            'auth_status': 2,
            'date': FieldValue.serverTimestamp(),
          });
        } else {
          await FirebaseCollectionReferances.users.collectRef
              .doc(FirebaseService().authID)
              .update({
            'profile_image': googleUser.photoUrl,
            'auth_status': 2,
          });
        }
        if (!event.context.mounted) return;
        emit(
          SignInGoogleAuthSuccess(
            AppLocalizations.of(event.context)!.sign_google_success,
          ),
        );
        return null;
      });
    } catch (error) {
      loggerPrint.printErrorLog('Hata: $error');
      emit(
        SignInGoogleAuthError(
          AppLocalizations.of(event.context)!.sign_google_error,
        ),
      );
      return null;
    }
  }
}
