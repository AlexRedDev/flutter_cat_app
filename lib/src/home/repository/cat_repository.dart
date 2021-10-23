import 'package:flutter_cat_app/src/home/api/cat_api_client.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

class CatRepository {
  CatApiClient _apiClient = CatApiClient();

  Future<List<Cat>> getCats([int page = 0]) async => await _apiClient.fetchCat(page);
}
