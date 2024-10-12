import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final BuildContext context;

  const SignInUserEvent(
    this.email,
    this.password,
    this.dynamicViewExtensions,
    this.context,
  );
}

class SignInUserGoogleEvent extends SignInEvent {
  final DynamicViewExtensions dynamicViewExtensions;
  final BuildContext context;

  const SignInUserGoogleEvent(
    this.dynamicViewExtensions,
    this.context,
  );
}
