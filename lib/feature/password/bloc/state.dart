import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:equatable/equatable.dart';

class PasswordState extends Equatable {
  final String email;

  const PasswordState({
    this.email = '',
  });

  PasswordState copyWith({
    String? email,
  }) {
    return PasswordState(
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [email];
}

class PasswordSuccessState extends PasswordState {
  final String message;

  const PasswordSuccessState(this.message);
}

class PasswordErrorState extends PasswordState {
  final String errorMessage;

  const PasswordErrorState(this.errorMessage);
}

class PasswordLoadingState extends PasswordState {
  final DynamicViewExtensions dynamicViewExtensions;

  const PasswordLoadingState(this.dynamicViewExtensions);
}
