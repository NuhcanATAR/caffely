import 'package:caffely/feature/account/view/center_help/bloc/cubit.dart';
import 'package:caffely/feature/account/view/center_help/bloc/event.dart';
import 'package:caffely/feature/account/view/center_help/centerhelp_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CenterHelpViewModel extends BaseState<CenterHelpView> {
  @override
  void initState() {
    super.initState();
    context.read<CenterHelpBloc>().add(LoadCenterHelpEvent());
  }
}
