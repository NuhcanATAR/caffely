import 'package:caffely/feature/store/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/feature/store/bloc/state.dart';
import 'package:caffely/feature/store/store_viewmodel.dart';
import 'package:caffely/feature/store/view/store_detail/storedetail_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:caffely/product/widget/widget/search_widget.dart';
import 'package:caffely/product/widget/widget/storecard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoresView extends StatefulWidget {
  const StoresView({super.key});

  @override
  State<StoresView> createState() => _StoresViewState();
}

class _StoresViewState extends StoresViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: AppIcons.arrowLeft.toSvgImg(
            Colors.black,
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        centerTitle: true,
        title: const BodyMediumBlackText(
          text: 'Şubeler',
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocBuilder<StoreBloc, StoresState>(
        builder: (context, state) {
          if (state is StoresLoading) {
            return const CustomLoadingResponseWidget(
              title: 'Şubeler Yükleniyor',
              subTitle: 'Lütfen Bekleyiniz.',
            );
          } else if (state is StoresLoaded) {
            return Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
              ),
              child: Column(
                children: <Widget>[
                  // search
                  SearchWidget(
                    controller: searchController,
                    searchText: 'Şube ara',
                    onChanged: (value) {
                      context.read<StoreBloc>().add(SearchStores(value));
                    },
                  ),
                  // list
                  Expanded(
                    child: state.stores.isEmpty
                        ? const CustomResponseWidget(
                            img: AppImages.notFound,
                            title: 'Caffely Şubesi Bulunamadı',
                            subTitle:
                                'Caffely Şubesi bulunamadı, isterseniz başka bir şube arayabilirsiniz.',
                          )
                        : ListView.builder(
                            itemCount: state.stores.length,
                            itemBuilder: (context, index) {
                              final store = state.stores[index];
                              return StoreCardWidget(
                                store: store,
                                dynamicViewExtensions: dynamicViewExtensions,
                                func: () {
                                  CodeNoahNavigatorRouter.push(
                                    context,
                                    StoreDetailView(
                                      storeModel: store,
                                    ),
                                  );
                                },
                                isCardStatus: false,
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          } else if (state is StoresLoaded) {
            if (state.stores.isEmpty) {
              return const Center(child: Text('No stores available'));
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
