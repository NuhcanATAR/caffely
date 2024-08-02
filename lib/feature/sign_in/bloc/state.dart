import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String email;
  final String password;

  const SignInState({
    this.email = "",
    this.password = "",
  });

  SignInState copyWith({
    String? email,
    String? password,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}

class SignInLoadingState extends SignInState {
  final DynamicViewExtensions dynamicViewExtensions;

  const SignInLoadingState(
    this.dynamicViewExtensions,
  );
}

class SignInSuccessState extends SignInState {
  final String message;

  const SignInSuccessState(this.message);
}

class SignInErrorState extends SignInState {
  final String message;

  const SignInErrorState(this.message);
}

class SignInGoogleAuthLoading extends SignInState {
  final DynamicViewExtensions dynamicViewExtensions;

  const SignInGoogleAuthLoading(
    this.dynamicViewExtensions,
  );
}

class SignInGoogleAuthSuccess extends SignInState {
    final String message;

  const SignInGoogleAuthSuccess(this.message);
}

class SignInGoogleAuthError extends SignInState {
  final String message;

  const SignInGoogleAuthError(this.message);
}
