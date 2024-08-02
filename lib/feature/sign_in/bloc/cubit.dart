import 'package:caffely/feature/sign_in/bloc/event.dart';
import 'package:caffely/feature/sign_in/bloc/state.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
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
        emit(
          const SignInErrorState('Oturumda kullanıcı bulunamadı!'),
        );
      } else {
        if (user.emailVerified) {
          emit(SignInSuccessState(user.uid));
        } else {
          emit(
            const SignInErrorState('Lütfen hesabınızı doğrulayın!'),
          );
          await user.sendEmailVerification();
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Kullanıcı bulunamadı!';
          break;
        case 'wrong-password':
          errorMessage = 'E-mail veya şifre hatalı';
          break;
        case 'too-many-requests':
          errorMessage =
              'Çok fazla hatalı giriş yaptınız, o yüzden hesabınız engellendi. Bir süre sonra tekrar deneyiniz.';
          break;
        case 'user-disabled':
          errorMessage = 'Bu hesap engellenmiştir!';
          break;
        default:
          errorMessage =
              'Hatalı bilgiler, lütfen bilgilerinizi kontrol ediniz.';
      }
      Logger().e('FirebaseAuthException: ${e.code} - ${e.message}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('remember_me', false);

      emit(SignInErrorState(errorMessage));
    } catch (e) {
      Logger().e('Unexpected Error: ${e.toString()}');
      emit(const SignInErrorState('Beklenmedik bir hata oluştu.'));
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
        }
        emit(
          const SignInGoogleAuthSuccess(
            'Google Hesabınıza giriş yapılıyor.',
          ),
        );
        return null;
      });
    } catch (error) {
      Logger().i('Hata: $error');
      emit(
        const SignInGoogleAuthError(
          'Giriş yaparken bir hata oluştu, lütfen daha sonra tekrar deneyiniz.',
        ),
      );
      return null;
    }
  }
}
