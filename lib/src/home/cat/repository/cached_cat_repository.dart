import 'package:flutter_cat_app/src/home/cat/repository/cat_repository.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

class CachedCatRepository implements CatRepository {
  @override
  Future<List<Cat>> getCats([int page = 0]) {
    // TODO: implement getCats
    throw UnimplementedError();
  }
}
