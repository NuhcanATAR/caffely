import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/feature/products/view/productdetail_view.dart';
import 'package:caffely/feature/store/bloc/cubit.dart';
import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/feature/store/bloc/state.dart';
import 'package:caffely/feature/store/view/store_information/storeinformation_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/productcard_widget.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'storedetail_viewmodel.dart';

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
          padding: PaddingSizedsUtility.all(
            PaddingSizedsUtility.smallPaddingValue,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: MarginSizedsUtility.all(
                MarginSizedsUtility.smallMarginValue,
              ),
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.smallPaddingValue,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    RadiusUtility.circularHighValue,
                  ),
                ),
              ),
              child: AppIcons.arrowLeft.toSvgImg(
                Colors.white,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
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

                // Favori kontrolü ve favori ID'sini alma
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
                    padding: PaddingSizedsUtility.right(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: Container(
                        padding: PaddingSizedsUtility.all(
                          PaddingSizedsUtility.smallPaddingValue,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              RadiusUtility.circularHighValue,
                            ),
                          ),
                        ),
                        child: isFavorite == true
                            ? AppIcons.favoriteFill.toSvgImg(
                                Colors.red,
                                IconSizedsUtility.normalSize,
                                IconSizedsUtility.normalSize,
                              )
                            : AppIcons.favoriteOutline.toSvgImg(
                                Colors.white,
                                IconSizedsUtility.normalSize,
                                IconSizedsUtility.normalSize,
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
          SliverToBoxAdapter(
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
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
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.normalPaddingValue,
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
                              IconSizedsUtility.normalSize,
                              IconSizedsUtility.normalSize,
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
                              message: 'Url Adresi Bulunamadı',
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
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.normalPaddingValue,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: PaddingSizedsUtility.bottom(
                                PaddingSizedsUtility.normalPaddingValue,
                              ),
                              child: AppIcons.locationFill.toSvgImg(
                                Theme.of(context).colorScheme.primary,
                                IconSizedsUtility.normalSize,
                                IconSizedsUtility.normalSize,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: PaddingSizedsUtility.horizontal(
                                  PaddingSizedsUtility.normalPaddingValue,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    // location
                                    SizedBox(
                                      width: dynamicViewExtensions
                                          .maxWidth(context),
                                      child: Padding(
                                        padding: PaddingSizedsUtility.bottom(
                                          PaddingSizedsUtility
                                              .smallPaddingValue,
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
                                      width: dynamicViewExtensions
                                          .maxWidth(context),
                                      child: Padding(
                                        padding: PaddingSizedsUtility.bottom(
                                          PaddingSizedsUtility
                                              .normalPaddingValue,
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
          ),
          BlocBuilder<StoreBloc, StoresState>(
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
                      );
                    },
                    childCount: productList.length,
                  ),
                );
              } else if (state is StoresError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error: ${state.message}'),
                  ),
                );
              } else {
                return const SliverToBoxAdapter();
              }
            },
          ),
        ],
      ),
    );
  }
}
