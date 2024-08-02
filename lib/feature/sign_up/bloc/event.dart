import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEmailEvent extends SignUpEvent {
  final String email;
  const SignUpEmailEvent(
    this.email,
  );

  @override
  List<Object> get props => [email];
}

class SignUpPasswordEvent extends SignUpEvent {
  final String password;

  const SignUpPasswordEvent(
    this.password,
  );

  @override
  List<Object> get props => [password];
}

class SignUpUserEvent extends SignUpEvent {
  final String email;
  final String password;

  const SignUpUserEvent(
    this.email,
    this.password,
  );
}
