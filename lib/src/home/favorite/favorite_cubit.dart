import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/favorite/favorite_state.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(FavoriteState initState) : super(initState);

  void changeFavorite(Cat cat) {
    if (state.cats.contains(cat)) {
      state.cats.remove(cat);
      emit(state.copyWith(cats: state.cats));
    } else {
      state.cats.add(cat);
      emit(state.copyWith(cats: state.cats));
    }
  }
}
