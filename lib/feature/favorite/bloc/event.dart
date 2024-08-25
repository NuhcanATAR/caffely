import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFavoriteProduct extends FavoriteEvent {}
