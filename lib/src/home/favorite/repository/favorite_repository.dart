import 'package:flutter_cat_app/src/home/models/cat.dart';

abstract class FavoriteRepository {
  void add(Cat cat);

  void delete(Cat cat);

  void deleteAll();

  Future<List<Cat>> getAllCat();
}
