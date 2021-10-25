import 'package:equatable/equatable.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

abstract class CatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCats extends CatEvent {}

class AddToFavorite extends CatEvent {
  final Cat cat;
  AddToFavorite(this.cat);

  @override
  List<Object?> get props => [cat];
}

class UpdateCats extends CatEvent {}
