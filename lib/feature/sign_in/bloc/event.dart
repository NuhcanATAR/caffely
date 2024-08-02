import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:equatable/equatable.dart';

class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInEmailEvent extends SignInEvent {
  final String email;

  const SignInEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class SignInPasswordEvent extends SignInEvent {
  final String password;
  const SignInPasswordEvent(this.password);
  @override
  List<Object> get props => [password];
}

class SignInUserEvent extends SignInEvent {
  final String email;
  final String password;
  final DynamicViewExtensions dynamicViewExtensions;

  const SignInUserEvent(
    this.email,
    this.password,
    this.dynamicViewExtensions,
  );
}

class SignInUserGoogleEvent extends SignInEvent {
  final DynamicViewExtensions dynamicViewExtensions;

  const SignInUserGoogleEvent(this.dynamicViewExtensions);
}
