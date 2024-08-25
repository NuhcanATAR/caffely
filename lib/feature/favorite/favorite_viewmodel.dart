import 'package:caffely/feature/favorite/bloc/cubit.dart';
import 'package:caffely/feature/favorite/bloc/event.dart';
import 'package:caffely/feature/favorite/favorite_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavoriteViewModel extends BaseState<FavoriteView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavoriteProduct());
  }
}
