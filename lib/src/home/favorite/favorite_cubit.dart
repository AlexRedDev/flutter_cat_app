import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/favorite/repository/favorite_repository.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';


import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteRepository favoriteRepository;

  FavoriteCubit({required this.favoriteRepository}) : super(FavoriteState());

  void loadFavorite() async {
    final cats = await favoriteRepository.getAllCat();
    emit(state.copyWith(cats: cats));
  }

  void deleteFavorite(Cat cat) {
    state.cats.removeWhere((element) => element.id == cat.id);
    favoriteRepository.delete(cat);
  }

  void deleteAll() {
    state.cats.clear();
    favoriteRepository.deleteAll();
  }
}
