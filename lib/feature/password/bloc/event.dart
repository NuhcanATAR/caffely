import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordEmailEvent extends PasswordEvent {
  final String email;

  const PasswordEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordResetEvent extends PasswordEvent {
  final String email;
  final DynamicViewExtensions dynamicViewExtensions;

  const PasswordResetEvent(this.email, this.dynamicViewExtensions);
}