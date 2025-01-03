// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/feature/products/product_detail/product_detail_view.dart';
import 'package:caffely/feature/store/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/feature/store/bloc/state.dart';
import 'package:caffely/feature/store/view/store_information/store_information_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/product_card_widget.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'store_detail_viewmodel.dart';

class StoreDetailView extends StatefulWidget {
  const StoreDetailView({
    super.key,
    required this.storeModel,
  });

  final StoreModel storeModel;

  @override
  State<StoreDetailView> createState() => _StoreDetailViewState();
}

class _StoreDetailViewState extends StoreDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: BaseUtility.all(
            BaseUtility.paddingSmallValue,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: BaseUtility.all(
                BaseUtility.marginSmallValue,
              ),
              padding: BaseUtility.all(
                BaseUtility.paddingSmallValue,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    BaseUtility.radiusCircularHighValue,
                  ),
                ),
              ),
              child: AppIcons.arrowLeft.toSvgImg(
                Colors.white,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
            ),
          ),
        ),
        actions: [
          // favorite
          BlocConsumer<StoreBloc, StoresState>(
            listener: storeFavoriteListenerBloc,
            builder: (context, state) {
              if (state is StoresLoading) {
                return const SizedBox();
              } else if (state is StoreDetailLoaded) {
                final favoriteList = state.favorites;
                final storeId = widget.storeModel.id;

                final favorite = favoriteList
                        .where((favorite) => favorite.storeId == storeId)
                        .toList()
                        .isNotEmpty
                    ? favoriteList
                        .where((favorite) => favorite.storeId == storeId)
                        .first
                    : null;

                final isFavorite = favorite != null;
                final favoriteId = favorite?.id;
                return GestureDetector(
                  onTap: () {
                    if (isFavorite) {
                      if (favoriteId != null) {
                        context.read<StoreBloc>().add(
                              StoreFavoriteCreateEvent(
                                storeId,
                                favoriteId,
                                false,
                                context,
                              ),
                            );
                        context.read<StoreBloc>().add(
                              LoadStoreDetail(
                                widget.storeModel.id,
                                "",
                              ),
                            );
                      }
                    } else {
                      context.read<StoreBloc>().add(
                            StoreFavoriteCreateEvent(
                              storeId,
                              '',
                              true,
                              context,
                            ),
                          );
                      context.read<StoreBloc>().add(
                            LoadStoreDetail(
                              widget.storeModel.id,
                              "",
                            ),
                          );
                    }
                  },
                  child: Padding(
                    padding: BaseUtility.right(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: Container(
                        padding: BaseUtility.all(
                          BaseUtility.paddingSmallValue,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              BaseUtility.radiusCircularHighValue,
                            ),
                          ),
                        ),
                        child: isFavorite == true
                            ? AppIcons.favoriteFill.toSvgImg(
                                Colors.red,
                                BaseUtility.iconNormalSize,
                                BaseUtility.iconNormalSize,
                              )
                            : AppIcons.favoriteOutline.toSvgImg(
                                Colors.white,
                                BaseUtility.iconNormalSize,
                                BaseUtility.iconNormalSize,
                              ),
                      ),
                    ),
                  ),
                );
              } else if (state is StoreDetailError) {
                return const SizedBox();
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // store images
          buildStoreImages,
          // store information
          buildStoreInformationWidget,
          // store products
          buildStoreProductsWidget,
        ],
      ),
    );
  }

  // store images
  SliverToBoxAdapter get buildStoreImages => SliverToBoxAdapter(
        child: SizedBox(
          width: dynamicViewExtensions.maxWidth(context),
          height: dynamicViewExtensions.dynamicHeight(context, 0.4),
          child: Stack(
            children: <Widget>[
              // slider
              Positioned(
                left: 0,
                right: 0,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: dynamicViewExtensions.dynamicHeight(
                      context,
                      0.4,
                    ),
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        current = index;
                      });
                    },
                  ),
                  items: coverImages
                      .map(
                        (item) => CachedNetworkImage(
                          imageUrl: item.toString(),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              // status bar
              const Positioned(
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
      );

  // store information
  Widget get buildStoreInformationWidget => SliverToBoxAdapter(
        child: Padding(
          padding: BaseUtility.all(
            BaseUtility.paddingNormalValue,
          ),
          child: Column(
            children: <Widget>[
              // title
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: GestureDetector(
                  onTap: () {
                    CodeNoahNavigatorRouter.push(
                      context,
                      StoreInformationView(
                        storeModel: widget.storeModel,
                      ),
                    );
                  },
                  child: Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TitleLargeBlackBoldText(
                            text: widget.storeModel.storeName,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        AppIcons.arrowRight.toSvgImg(
                          Colors.black,
                          BaseUtility.iconNormalSize,
                          BaseUtility.iconNormalSize,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // location
              SizedBox(
                width: dynamicViewExtensions.maxWidth(context),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.storeModel.locationUrl.isEmpty) {
                      unawaited(
                        CodeNoahDialogs(context).showFlush(
                          type: SnackType.error,
                          message: AppLocalizations.of(context)!
                              .stores_detail_location_not_found,
                        ),
                      );
                    } else {
                      if (!await launchUrl(
                        Uri.parse(
                          widget.storeModel.locationUrl,
                        ),
                      )) {
                        throw ServiceException('Could not launch url');
                      }
                    }
                  },
                  child: Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: BaseUtility.bottom(
                            BaseUtility.paddingNormalValue,
                          ),
                          child: AppIcons.locationFill.toSvgImg(
                            Theme.of(context).colorScheme.primary,
                            BaseUtility.iconNormalSize,
                            BaseUtility.iconNormalSize,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: BaseUtility.horizontal(
                              BaseUtility.paddingNormalValue,
                            ),
                            child: Column(
                              children: <Widget>[
                                // location
                                SizedBox(
                                  width:
                                      dynamicViewExtensions.maxWidth(context),
                                  child: Padding(
                                    padding: BaseUtility.bottom(
                                      BaseUtility.paddingSmallValue,
                                    ),
                                    child: BodyMediumBlackBoldText(
                                      text:
                                          '${widget.storeModel.locationCity} / ${widget.storeModel.locationDistrict} / ${widget.storeModel.locationNeighborhood}',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                // open time
                                SizedBox(
                                  width:
                                      dynamicViewExtensions.maxWidth(context),
                                  child: Padding(
                                    padding: BaseUtility.bottom(
                                      BaseUtility.paddingNormalValue,
                                    ),
                                    child: BodyMediumBlackText(
                                      text:
                                          '${openDateTime.hour}:${openDateTime.minute} / ${closeDateTime.hour}:${closeDateTime.minute}',
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
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // store products
  Widget get buildStoreProductsWidget => BlocBuilder<StoreBloc, StoresState>(
        builder: (context, state) {
          if (state is StoresLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is StoreDetailLoaded) {
            final productList = state.products;
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 40.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final product = productList[index];
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
                    isCardStatus: ProductCardType.horizontal,
                  );
                },
                childCount: productList.length,
              ),
            );
          } else if (state is StoresError) {
            return const SliverToBoxAdapter(child: SizedBox());
          } else {
            return const SliverToBoxAdapter();
          }
        },
      );
}
