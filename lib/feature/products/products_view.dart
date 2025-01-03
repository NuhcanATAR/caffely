import 'package:caffely/feature/products/bloc/cubit.dart';
import 'package:caffely/feature/products/bloc/event.dart';
import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/feature/products/product_detail/product_detail_view.dart';
import 'package:caffely/feature/products/products_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/product_filter_control.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/product_card_widget.dart';
import 'package:caffely/product/widget/widget/response_widget.dart';
import 'package:caffely/product/widget/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({
    super.key,
    required this.isPopularFilter,
  });

  final ProductFilterControl isPopularFilter;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends ProductsViewModel {
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
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
        centerTitle: true,
        title: BodyMediumBlackText(
          text: AppLocalizations.of(context)!.products_appbar,
          textAlign: TextAlign.left,
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return CustomLoadingResponseWidget(
              title: AppLocalizations.of(context)!.products_loading_title,
              subTitle: AppLocalizations.of(context)!.products_loading_subtitle,
            );
          } else if (state is ProductLoaded) {
            return Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingNormalValue,
              ),
              child: Column(
                children: <Widget>[
                  // search
                  SearchWidget(
                    controller: searchController,
                    searchText: AppLocalizations.of(context)!.products_search,
                    onChanged: (value) {
                      context.read<ProductBloc>().add(
                            SearchProducts(value),
                          );
                    },
                  ),
                  // list
                  Expanded(
                    child: state.products.isEmpty
                        ? CustomResponseWidget(
                            img: AppImages.notFoundSecond,
                            title: AppLocalizations.of(context)!
                                .products_empty_title,
                            subTitle: AppLocalizations.of(context)!
                                .products_empty_subtitle,
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
