import 'package:caffely/feature/store/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/feature/store/bloc/state.dart';
import 'package:caffely/feature/store/store_viewmodel.dart';
import 'package:caffely/feature/store/view/store_detail/storedetail_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/constants/logo.dart';
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.smallPaddingValue,
          ),
          child: AppLogoConstants.appLogoNoBackgroundColorPrimary.toImg,
        ),
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.stores_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocBuilder<StoreBloc, StoresState>(
        builder: (context, state) {
          if (state is StoresLoading) {
            return CustomLoadingResponseWidget(
              title: AppLocalizations.of(context)!.stores_loading_title,
              subTitle: AppLocalizations.of(context)!.stores_loading_subtitle,
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
                    searchText: AppLocalizations.of(context)!.stores_search,
                    onChanged: (value) {
                      context.read<StoreBloc>().add(SearchStores(value));
                    },
                  ),
                  // list
                  Expanded(
                    child: state.stores.isEmpty
                        ? CustomResponseWidget(
                            img: AppImages.notFound,
                            title: AppLocalizations.of(context)!
                                .stores_empty_title,
                            subTitle: AppLocalizations.of(context)!
                                .stores_empty_subtitle,
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
          }
          return const SizedBox();
        },
      ),
    );
  }
}
