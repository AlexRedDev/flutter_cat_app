import 'package:flutter_cat_app/src/home/models/cat.dart';

class FavoriteState {
  final List<Cat> cats;

  FavoriteState({this.cats = const []});

  FavoriteState copyWith({List<Cat>? cats}) {
    return FavoriteState(cats: cats ?? this.cats);
  }
}
