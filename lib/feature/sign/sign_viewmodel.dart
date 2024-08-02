import 'package:caffely/feature/sign/sign_view.dart';
import 'package:caffely/feature/sign_in/bloc/mixin.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';

abstract class SignViewModel extends BaseState<SignView> with SignInMixin {}
