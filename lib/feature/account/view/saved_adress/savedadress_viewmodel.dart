import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/mixin.dart';
import 'package:caffely/feature/account/view/saved_adress/savedadress_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SavedAdressViewModel extends BaseState<SavedAdressView>
    with SavedAdressMixin {
  @override
  void initState() {
    super.initState();
    context.read<SavedAdressBloc>().add(LoadSavedAdressEvent(context));
  }
}
