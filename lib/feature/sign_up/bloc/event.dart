import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final BuildContext context;

  const SignUpUserEvent(
    this.email,
    this.password,
    this.context,
  );
}
