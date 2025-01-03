import 'package:caffely/feature/home/bloc/cubit.dart';
import 'package:caffely/feature/home/bloc/event.dart';
import 'package:caffely/feature/home/home_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeViewModel extends BaseState<HomeView> {
  final int timeHour = DateTime.now().hour;
  int current = 0;

  CarouselController carouselController = CarouselController();
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHome());
  }
}
