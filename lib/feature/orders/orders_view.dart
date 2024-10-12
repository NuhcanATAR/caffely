import 'package:caffely/feature/orders/bloc/cubit.dart';
import 'package:caffely/feature/orders/bloc/state.dart';
import 'package:caffely/feature/orders/orders_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/order_card_widget.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends OrdersViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.smallPaddingValue,
          ),
          child: AppLogoConstants.appLogoNoBackgroundColorPrimary.toImg,
        ),
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.order_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrderLoaded) {
            branches = state.branches;
            return buildBodyWidget(state);
          } else if (state is OrderError) {
            return CustomResponseWidget(
              img: AppImages.error,
              title: AppLocalizations.of(context)!.order_error_title,
              subTitle: AppLocalizations.of(context)!.order_error_subtitle,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  // body
  Widget buildBodyWidget(OrderLoaded state) => state.orders.isEmpty
      ? CustomResponseWidget(
          img: AppImages.notFound,
          title: AppLocalizations.of(context)!.order_empty_title,
          subTitle: AppLocalizations.of(context)!.order_empty_subtitle,
        )
      : Padding(
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.normalPaddingValue,
          ),
          child: ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final model = state.orders[index];
              final date = model.date!.toDate();
              final createDate = '${date.day}.${date.month}.${date.year}';
              return OrderCardWidget(
                createDate: createDate,
                model: model,
              );
            },
          ),
        );
}
