import 'package:caffely/feature/store/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/feature/store/bloc/mixin.dart';
import 'package:caffely/feature/store/view/store_detail/storedetail_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StoreDetailViewModel extends BaseState<StoreDetailView>
    with StoreMixin {
  int current = 0;

  CarouselController carouselController = CarouselController();

  late List<String> coverImages;

  late DateTime openDateTime = widget.storeModel.openingTime!.toDate();
  late DateTime closeDateTime = widget.storeModel.closingTime!.toDate();

  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(
          LoadStoreDetail(
            widget.storeModel.id,
            "",
          ),
        );

    coverImages = [
      widget.storeModel.coverImage,
      widget.storeModel.coverSeconImage,
      widget.storeModel.coverThreeImage,
    ];
  }
}
