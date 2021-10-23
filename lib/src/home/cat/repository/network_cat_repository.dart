import 'package:flutter_cat_app/src/home/api/cat_api_client.dart';
import 'package:flutter_cat_app/src/home/cat/repository/cat_repository.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

class NetworkCatRepository implements CatRepository{

  final CatApiClient _apiClient = CatApiClient();
  
  @override
  Future<List<Cat>> getCats([int page = 0]) async {
    final catResponse = await _apiClient.fetchCatsResponse(page);
    final factResponse = await _apiClient.fetchFactResponse();
    List<Cat> cats = [];
    for (var i = 0; i < 10; i++) {
      cats.add(Cat(
        id: catResponse[i].id,
        imagUrl: catResponse[i].imgUrl,
        catFact: factResponse[i].fact,
      ));
    }
    return cats;
  }
  
}
