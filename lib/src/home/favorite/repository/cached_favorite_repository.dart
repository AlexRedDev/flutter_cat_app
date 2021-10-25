import 'package:flutter_cat_app/src/cached/cached_hive_favorite.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

import 'favorite_repository.dart';

class CachedFavoriteRepository implements FavoriteRepository {
  CachedHiveFavorite hiveFavorite = CachedHiveFavorite();

  @override
  void add(Cat cat) => hiveFavorite.addCat(cat);

  @override
  void delete(Cat cat) => hiveFavorite.deleteAt(cat);

  @override
  void deleteAll() => hiveFavorite.deleteAll();

  @override
  Future<List<Cat>> getAllCat() => hiveFavorite.getCats();
}
