import 'package:caffely/feature/store/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/feature/store/store_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StoresViewModel extends BaseState<StoresView> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(LoadStores(""));
  }
}
