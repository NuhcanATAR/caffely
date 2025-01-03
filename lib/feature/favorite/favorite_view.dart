import 'package:caffely/feature/favorite/bloc/cubit.dart';
import 'package:caffely/feature/favorite/bloc/state.dart';
import 'package:caffely/feature/favorite/favorite_viewmodel.dart';
import 'package:caffely/feature/products/product_detail/product_detail_view.dart';
import 'package:caffely/feature/store/view/store_detail/store_detail_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/product_card_widget.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:caffely/product/widget/widget/store_card_widget.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends FavoriteViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
          padding: BaseUtility.all(
            BaseUtility.paddingSmallValue,
          ),
          child: AppLogoConstants.appLogoNoBackgroundColorPrimary.toImg,
        ),
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.favorite_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return CustomLoadingResponseWidget(
                title: AppLocalizations.of(context)!.favorite_loading_title,
                subTitle:
                    AppLocalizations.of(context)!.favorite_loading_subtitle,
              );
            } else if (state is FavoriteLoaded) {
              return ContainedTabBarView(
                tabs: [
                  BodyMediumMainColorText(
                    text: AppLocalizations.of(context)!
                        .favorite_contained_tabs_product,
                    textAlign: TextAlign.center,
                  ),
                  BodyMediumMainColorText(
                    text: AppLocalizations.of(context)!
                        .favorite_contained_tabs_stores,
                    textAlign: TextAlign.center,
                  ),
                ],
                views: [
                  state.products.isEmpty
                      ? CustomResponseWidget(
                          img: AppImages.notFoundSecond,
                          title: AppLocalizations.of(context)!
                              .favorite_products_empty_title,
                          subTitle: AppLocalizations.of(context)!
                              .favorite_products_empty_subtitle,
                        )
                      : ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCardWidget(
                              product: product,
                              dynamicViewExtensions: dynamicViewExtensions,
                              func: () {
                                CodeNoahNavigatorRouter.push(
                                  context,
                                  ProductDetailView(
                                    productModel: product,
                                  ),
                                );
                              },
                              isCardStatus: ProductCardType.veritical,
                            );
                          },
                        ),
                  state.stores.isEmpty
                      ? CustomResponseWidget(
                          img: AppImages.notFound,
                          title: AppLocalizations.of(context)!
                              .favorite_stores_empty_title,
                          subTitle: AppLocalizations.of(context)!
                              .favorite_stores_empty_subtitle,
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
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
