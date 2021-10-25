import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/cat/cat_bloc.dart';
import 'package:flutter_cat_app/src/home/favorite/favorite_event.dart';
import 'package:flutter_cat_app/src/home/favorite/repository/favorite_repository.dart';

import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc({
    required this.favoriteRepository,
  }) : super(FavoriteState()) {
    on<LoadFavorite>(_onLoadFavorite);
    on<DeleteFavorite>(_onDeleteFavorite);
    on<DeleteAllFavorite>(_onDeleteAllFavorite);
  }

  void _onLoadFavorite(
    LoadFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final cats = await favoriteRepository.getAllCat();
    emit(state.copyWith(cats: cats));
  }

  void _onDeleteFavorite(
    DeleteFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    state.cats.removeWhere((element) => element.id == event.cat.id);
    emit(state.copyWith(cats: state.cats));
    favoriteRepository.delete(event.cat);
  }

  void _onDeleteAllFavorite(
    DeleteAllFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    state.cats.clear();
    emit(state.copyWith(cats: state.cats));
    favoriteRepository.deleteAll();
  }
}
