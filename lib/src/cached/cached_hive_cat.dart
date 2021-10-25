import 'package:flutter_cat_app/src/home/models/cat.dart';
import 'package:hive/hive.dart';

const String _catFavofireBox = 'CAT';

class CachedHiveFavorite {
  void addCat(Cat cat) async {
    final box = await _boxCat();
    box.put(cat.id, cat);
  }

  void addCats(List<Cat> cats) async {
    final box = await _boxCat();
    for (var cat in cats) {
      box.put(cat.id, cat);
    }
  }

  void deleteAt(Cat cat) async {
    final box = await _boxCat();
    box.delete(cat.id);
  }

  void deleteAll() async {
    final box = await _boxCat();
    box.clear();
  }

  Future<List<Cat>> getCats() async {
    final box = await _boxCat();
    final mapCat = box.toMap();

    List<Cat> cats = [];
    mapCat.forEach((key, value) => cats.add(value));
    return cats;
  }

  static Future<Box<Cat>> _boxCat() async {
    if (Hive.isBoxOpen(_catFavofireBox)) {
      return Hive.box(_catFavofireBox);
    } else {
      return await Hive.openBox(_catFavofireBox);
    }
  }
}
