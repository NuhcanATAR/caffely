import 'package:caffely/feature/favorite/bloc/cubit.dart';
import 'package:caffely/feature/favorite/bloc/state.dart';
import 'package:caffely/feature/favorite/favorite_viewmodel.dart';
import 'package:caffely/feature/products/product_detail/productdetail_view.dart';
import 'package:caffely/feature/store/view/store_detail/storedetail_view.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/productcard_widget.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:caffely/product/widget/widget/storecard_widget.dart';
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
        title: const BodyMediumBlackText(
          text: 'Favoriler',
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const CustomLoadingResponseWidget(
                title: 'Ürünler Yükleniyor',
                subTitle: 'Lütfen Bekleyiniz.',
              );
            } else if (state is FavoriteLoaded) {
              return ContainedTabBarView(
                tabs: const [
                  BodyMediumMainColorText(
                    text: 'Kahveler',
                    textAlign: TextAlign.center,
                  ),
                  BodyMediumMainColorText(
                    text: 'Şubeler',
                    textAlign: TextAlign.center,
                  ),
                ],
                views: [
                  state.products.isEmpty
                      ? const CustomResponseWidget(
                          img: AppImages.notFoundSecond,
                          title: 'Ürün Bulunamadı',
                          subTitle:
                              'Henüz favori ürününüz bulunmuyor isterseniz favori ürün oluşturmaya başlayabilirsiniz.',
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
                      ? const CustomResponseWidget(
                          img: AppImages.notFound,
                          title: 'Şube Bulunamadı',
                          subTitle:
                              'Henüz favori şubeniz bulunmuyor isterseniz favori şubenizi eklemeye başlayabilirsiniz.',
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
            } else if (state is FavoriteLoaded) {
              if (state.products.isEmpty) {
                return const CustomResponseWidget(
                  img: AppImages.notFoundSecond,
                  title: 'Ürün Bulunamadı',
                  subTitle:
                      'Henüz favori ürününüz bulunmuyor isterseniz favori ürün oluşturmaya başlayabilirsiniz.',
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
