import 'package:flutter_cat_app/src/home/api/cat_api_client.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

abstract class CatRepository {
  Future<List<Cat>> getCats([int page = 0]);
}
