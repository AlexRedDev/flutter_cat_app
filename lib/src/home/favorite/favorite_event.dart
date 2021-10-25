import 'package:equatable/equatable.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavorite extends FavoriteEvent {}

class DeleteFavorite extends FavoriteEvent {
  final Cat cat;
  DeleteFavorite(this.cat);

  @override
  List<Object?> get props => [cat];
}

class DeleteAllFavorite extends FavoriteEvent {}
