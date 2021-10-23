import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

const String _catFavofireBox = 'CAT_FAVORITE';

//Todo: remove OpenBox this important
class CachedHiveFavorite {
  void addCat(Cat cat) async {
    final box = await Hive.openBox<Cat>(_catFavofireBox);
    box.put(cat.id, cat);
  }

  void addCats(List<Cat> cats) async {
    final box = await Hive.openBox<Cat>(_catFavofireBox);
    for (var cat in cats) {
      box.put(cat.id, cat);
    }
  }

  void deleteAt(Cat cat) async {
    final box = await Hive.openBox<Cat>(_catFavofireBox);
    box.delete(cat.id);
  }

  void deleteAll() async {
    final box = await Hive.openBox<Cat>(_catFavofireBox);
    box.clear();
  }

  @override
  Future<List<Cat>> getCats() async {
    final box = await Hive.openBox(_catFavofireBox);
    final mapCat = box.toMap();

    List<Cat> cats = [];
    mapCat.forEach((key, value) => cats.add(value));
    return cats;
  }
}
