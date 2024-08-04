import 'package:caffely/feature/home/bloc/cubit.dart';
import 'package:caffely/feature/home/bloc/event.dart';
import 'package:caffely/feature/home/home_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeViewModel extends BaseState<HomeView> {
  late DateTime dateTime = DateTime.now();
  late int timeHour = dateTime.hour;
  int current = 0;

  late CarouselController carouselController = CarouselController();
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHome());
  }
}
