import 'package:caffely/feature/account/account_view.dart';
import 'package:caffely/feature/home/bloc/cubit.dart';
import 'package:caffely/feature/home/bloc/state.dart';
import 'package:caffely/feature/home/home_viewmodel.dart';
import 'package:caffely/feature/notification/notification_view.dart';
import 'package:caffely/feature/products/product_detail/productdetail_view.dart';
import 'package:caffely/feature/products/products_view.dart';
import 'package:caffely/feature/store/store_view.dart';
import 'package:caffely/feature/store/view/store_detail/storedetail_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/auth_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/productfilter_control.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/productcard_widget.dart';
import 'package:caffely/product/widget/widget/slidercard_widget.dart';
import 'package:caffely/product/widget/widget/storecard_widget.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        automaticallyImplyLeading: true,
        toolbarHeight: 120,
        titleSpacing: PaddingSizedsUtility.normalPaddingValue,
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
                                  RadiusUtility.circularHighValue,
                                ),
                              )
                            : BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(user.profileImage),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(
                                  RadiusUtility.circularHighValue,
                                ),
                              ),
                        child: user.authStatus ==
                                AuthControl.emailPasswordAuth.valueAuth
                            ? AppIcons.userOutline.toSvgImg(
                                Colors.white,
                                IconSizedsUtility.normalSize,
                                IconSizedsUtility.normalSize,
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: PaddingSizedsUtility.horizontal(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: Column(
                          children: <Widget>[
                            // title
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: PaddingSizedsUtility.vertical(
                                  PaddingSizedsUtility.smallPaddingValue,
                                ),
                                child: BodyMediumBlackText(
                                  text: timeHour > 18
                                      ? 'İyi akşamlar 🌃'
                                      : timeHour < 18
                                          ? 'Günaydın ⛅'
                                          : 'Bilinmiyor',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            // name surname
                            SizedBox(
                              width: dynamicViewExtensions.maxWidth(context),
                              child: Padding(
                                padding: PaddingSizedsUtility.bottom(
                                  PaddingSizedsUtility.smallPaddingValue,
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
          GestureDetector(
            onTap: () {
              CodeNoahNavigatorRouter.push(
                context,
                const NotificationView(),
              );
            },
            child: Container(
              margin: MarginSizedsUtility.right(
                MarginSizedsUtility.normalMarginValue,
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        RadiusUtility.circularHighValue,
                      ),
                    ),
                  ),
                  child: AppIcons.notificationOutline.toSvgImg(
                    null,
                    IconSizedsUtility.normalSize,
                    IconSizedsUtility.normalSize,
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
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
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
                              padding: PaddingSizedsUtility.vertical(
                                PaddingSizedsUtility.normalPaddingValue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    state.banners.asMap().entries.map((entry) {
                                  return Padding(
                                    padding: PaddingSizedsUtility.horizontal(
                                      PaddingSizedsUtility.smallPaddingValue,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => carouselController,
                                      child: Icon(
                                        Icons.circle,
                                        size: IconSizedsUtility.xSmallSize,
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
                          padding: PaddingSizedsUtility.vertical(
                            PaddingSizedsUtility.normalPaddingValue,
                          ),
                          child: Column(
                            children: <Widget>[
                              // title
                              Padding(
                                padding: PaddingSizedsUtility.bottom(
                                  PaddingSizedsUtility.normalPaddingValue,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const Expanded(
                                      flex: 2,
                                      child: TitleMediumBlackBoldText(
                                        text: 'Caffely Şubeleri',
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
                                            const Flexible(
                                              fit: FlexFit.tight,
                                              flex: 1,
                                              child: BodyMediumMainColorText(
                                                text: 'Daha fazla',
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            AppIcons.arrowRight.toSvgImg(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              IconSizedsUtility
                                                  .mediumSecondSize,
                                              IconSizedsUtility
                                                  .mediumSecondSize,
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
                                  padding: PaddingSizedsUtility.vertical(
                                    PaddingSizedsUtility.smallPaddingValue,
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
                          padding: PaddingSizedsUtility.vertical(
                            PaddingSizedsUtility.normalPaddingValue,
                          ),
                          child: Column(
                            children: <Widget>[
                              // title
                              Padding(
                                padding: PaddingSizedsUtility.bottom(
                                  PaddingSizedsUtility.normalPaddingValue,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const Expanded(
                                      flex: 2,
                                      child: TitleMediumBlackBoldText(
                                        text: 'Popüler Kahveler',
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
                                            const Flexible(
                                              fit: FlexFit.tight,
                                              flex: 1,
                                              child: BodyMediumMainColorText(
                                                text: 'Daha fazla',
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            AppIcons.arrowRight.toSvgImg(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              IconSizedsUtility
                                                  .mediumSecondSize,
                                              IconSizedsUtility
                                                  .mediumSecondSize,
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
                                  padding: PaddingSizedsUtility.vertical(
                                    PaddingSizedsUtility.smallPaddingValue,
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
          } else if (state is HomeLoaded) {
            if (state.banners.isEmpty) {
              return const Center(child: Text('No banners available'));
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
