// ignore_for_file: deprecated_member_use

import 'package:caffely/feature/account/account_view.dart';
import 'package:caffely/feature/basket/basket_view.dart';
import 'package:caffely/feature/home/bloc/cubit.dart';
import 'package:caffely/feature/home/bloc/state.dart';
import 'package:caffely/feature/home/home_viewmodel.dart';
import 'package:caffely/feature/notification/notification_view.dart';
import 'package:caffely/feature/products/product_detail/product_detail_view.dart';
import 'package:caffely/feature/products/products_view.dart';
import 'package:caffely/feature/store/store_view.dart';
import 'package:caffely/feature/store/view/store_detail/store_detail_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/auth_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/product_filter_control.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/product_card_widget.dart';
import 'package:caffely/product/widget/widget/slider_card_widget.dart';
import 'package:caffely/product/widget/widget/store_card_widget.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../lang/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        titleSpacing: BaseUtility.paddingNormalValue,
        title: FutureBuilder<UserModel>(
          future: getUserFromFireStore(FirebaseService().authID.toString()),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.hasError) {
              return const SizedBox();
            }

            if (snapshot.hasData) {
              final user = snapshot.data!;
              return GestureDetector(
                onTap: () {
                  CodeNoahNavigatorRouter.push(
                    context,
                    const AccountView(),
                  );
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: user.authStatus ==
                                AuthControl.emailPasswordAuth.valueAuth
                            ? BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                  BaseUtility.radiusCircularHighValue,
                                ),
                              )
                            : BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(user.profileImage),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(
                                  BaseUtility.radiusCircularHighValue,
                                ),
                              ),
                        child: user.authStatus ==
                                AuthControl.emailPasswordAuth.valueAuth
                            ? AppIcons.userOutline.toSvgImg(
                                Colors.white,
                                BaseUtility.iconNormalSize,
                                BaseUtility.iconNormalSize,
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: BaseUtility.horizontal(
                          BaseUtility.paddingNormalValue,
                        ),
                        child: Column(
                          children: <Widget>[
                            // title
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: BaseUtility.vertical(
                                  BaseUtility.paddingSmallValue,
                                ),
                                child: BodyMediumBlackText(
                                  text: timeHour > 18
                                      ? '${AppLocalizations.of(context)!.home_appbar_good_evening} 🌃'
                                      : timeHour < 18
                                          ? '${AppLocalizations.of(context)!.home_appbar_good_morning} ⛅'
                                          : AppLocalizations.of(context)!
                                              .home_appbar_unknown,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            // name surname
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: BaseUtility.bottom(
                                  BaseUtility.paddingSmallValue,
                                ),
                                child: TitleMediumBlackBoldText(
                                  text: user.nameSurname,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        actions: [
          // basket
          GestureDetector(
            onTap: () {
              CodeNoahNavigatorRouter.push(
                context,
                const BasketView(),
              );
            },
            child: Container(
              margin: BaseUtility.right(
                BaseUtility.marginNormalValue,
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        BaseUtility.radiusCircularHighValue,
                      ),
                    ),
                  ),
                  child: AppIcons.basketOutline.toSvgImg(
                    null,
                    BaseUtility.iconMediumSecondSize,
                    BaseUtility.iconMediumSecondSize,
                  ),
                ),
              ),
            ),
          ),
          // notification
          GestureDetector(
            onTap: () {
              CodeNoahNavigatorRouter.push(
                context,
                const NotificationView(),
              );
            },
            child: Container(
              margin: BaseUtility.right(
                BaseUtility.marginNormalValue,
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        BaseUtility.radiusCircularHighValue,
                      ),
                    ),
                  ),
                  child: AppIcons.notificationOutline.toSvgImg(
                    null,
                    BaseUtility.iconNormalSize,
                    BaseUtility.iconNormalSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeBannerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingNormalValue,
              ),
              child: ListView(
                children: <Widget>[
                  // banner
                  state.banners.isEmpty
                      ? const SizedBox()
                      : Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 180.0,
                                enableInfiniteScroll: false,
                                viewportFraction: 1.0,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    current = index;
                                  });
                                },
                              ),
                              items: state.banners
                                  .map(
                                    (item) => SliderCardWidget(
                                      item: item,
                                    ),
                                  )
                                  .toList(),
                            ),
                            Padding(
                              padding: BaseUtility.vertical(
                                BaseUtility.paddingNormalValue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    state.banners.asMap().entries.map((entry) {
                                  return Padding(
                                    padding: BaseUtility.horizontal(
                                      BaseUtility.paddingSmallValue,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => carouselController,
                                      child: Icon(
                                        Icons.circle,
                                        size: BaseUtility.iconXSmallSize,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary)
                                            .withOpacity(
                                          current == entry.key ? 0.9 : 0.4,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                  // stores
                  state.stores.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: BaseUtility.vertical(
                            BaseUtility.paddingNormalValue,
                          ),
                          child: Column(
                            children: <Widget>[
                              // title
                              Padding(
                                padding: BaseUtility.bottom(
                                  BaseUtility.paddingNormalValue,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: TitleMediumBlackBoldText(
                                        text: AppLocalizations.of(context)!
                                            .home_stores_list_title,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          CodeNoahNavigatorRouter.push(
                                            context,
                                            const StoresView(),
                                          );
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.tight,
                                              flex: 1,
                                              child: BodyMediumMainColorText(
                                                text: AppLocalizations.of(
                                                  context,
                                                )!
                                                    .home_stores_list_next,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            AppIcons.arrowRight.toSvgImg(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              BaseUtility.iconMediumSecondSize,
                                              BaseUtility.iconMediumSecondSize,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // list
                              SizedBox(
                                width: dynamicViewExtensions.maxWidth(context),
                                height: dynamicViewExtensions.dynamicHeight(
                                  context,
                                  0.3,
                                ),
                                child: Padding(
                                  padding: BaseUtility.vertical(
                                    BaseUtility.paddingSmallValue,
                                  ),
                                  child: ListView.builder(
                                    itemCount: state.stores.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final store = state.stores[index];
                                      return StoreCardWidget(
                                        func: () {
                                          CodeNoahNavigatorRouter.push(
                                            context,
                                            StoreDetailView(
                                              storeModel: store,
                                            ),
                                          );
                                        },
                                        store: store,
                                        dynamicViewExtensions:
                                            dynamicViewExtensions,
                                        isCardStatus: true,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  // popular product
                  state.products.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: BaseUtility.vertical(
                            BaseUtility.paddingNormalValue,
                          ),
                          child: Column(
                            children: <Widget>[
                              // title
                              Padding(
                                padding: BaseUtility.bottom(
                                  BaseUtility.paddingNormalValue,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: TitleMediumBlackBoldText(
                                        text: AppLocalizations.of(context)!
                                            .home_popular_products_list_title,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          CodeNoahNavigatorRouter.push(
                                            context,
                                            const ProductsView(
                                              isPopularFilter:
                                                  ProductFilterControl
                                                      .favoriteFilter,
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.tight,
                                              flex: 1,
                                              child: BodyMediumMainColorText(
                                                text: AppLocalizations.of(
                                                  context,
                                                )!
                                                    .home_popular_products_list_next,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            AppIcons.arrowRight.toSvgImg(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              BaseUtility.iconMediumSecondSize,
                                              BaseUtility.iconMediumSecondSize,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // list
                              SizedBox(
                                width: dynamicViewExtensions.maxWidth(context),
                                height: dynamicViewExtensions.dynamicHeight(
                                  context,
                                  0.3,
                                ),
                                child: Padding(
                                  padding: BaseUtility.vertical(
                                    BaseUtility.paddingSmallValue,
                                  ),
                                  child: ListView.builder(
                                    itemCount: state.products.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final product = state.products[index];
                                      return ProductCardWidget(
                                        product: product,
                                        dynamicViewExtensions:
                                            dynamicViewExtensions,
                                        func: () {
                                          CodeNoahNavigatorRouter.push(
                                            context,
                                            ProductDetailView(
                                              productModel: product,
                                            ),
                                          );
                                        },
                                        isCardStatus:
                                            ProductCardType.horizontal,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
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
