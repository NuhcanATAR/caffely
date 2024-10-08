import 'package:caffely/feature/orders/bloc/cubit.dart';
import 'package:caffely/feature/orders/bloc/state.dart';
import 'package:caffely/feature/orders/orders_viewmodel.dart';
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
        title: const BodyMediumBlackText(
          text: 'Siparişlerim',
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
            return const CustomResponseWidget(
              img: AppImages.error,
              title: 'Siparişler Bulunamadı',
              subTitle:
                  'Siparişler yüklenirken bir hata oluştu, lütfen daha sonra tekrar deneyiniz.',
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
      ? const CustomResponseWidget(
          img: AppImages.notFound,
          title: 'Siparişiniz Bulunmuyor',
          subTitle:
              'Henüz yeni bir sipariş oluşturmadınız, isterseniz yeni sipariş oluşturmaya başlayabilirsiniz.',
        )
      : Padding(
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.normalPaddingValue,
          ),
          child: state.orders.isEmpty
              ? const CustomResponseWidget(
                  img: AppImages.notFound,
                  title: 'Hazırlanmakta Olan Sipariş Bulunmuyor',
                  subTitle:
                      'Henüz hazırlanmak üzere olan bir siparişiniz bulunmuyor.',
                )
              : ListView.builder(
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
