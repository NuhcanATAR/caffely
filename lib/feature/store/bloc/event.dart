import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class StoresEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStores extends StoresEvent {
  final String productId;

  LoadStores(this.productId);
}

class LoadStoreDetail extends StoresEvent {
  final String storeId;
  final String productId;

  LoadStoreDetail(this.storeId, this.productId);
}

class LoadFavorite extends StoresEvent {
  final String productId;

  LoadFavorite(this.productId);
}

class SearchStores extends StoresEvent {
  final String query;

  SearchStores(this.query);

  @override
  List<Object> get props => [query];
}

class StoreFavoriteCreateEvent extends StoresEvent {
  final String storeId;
  final String favoriteId;
  final bool isFavoriteStatus;
  final BuildContext context;

  StoreFavoriteCreateEvent(
    this.storeId,
    this.favoriteId,
    this.isFavoriteStatus,
    this.context,
  );
}
