import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String email;
  final String password;

  const SignUpState({
    this.email = "",
    this.password = "",
  });

  SignUpState copyWith({
    String? email,
    String? password,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final String message;

  const SignUpSuccessState(this.message);
}

class SignUpErrorState extends SignUpState {
  final String message;

  const SignUpErrorState(this.message);
}
