import 'package:flutter_cat_app/src/home/api/cat_api_client.dart';
import 'package:flutter_cat_app/src/home/cat/repository/cat_repository.dart';
import 'package:flutter_cat_app/src/home/favorite/repository/favorite_repository.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

class NetworkCatRepository implements CatRepository {
  final CatApiClient _apiClient = CatApiClient();
  final FavoriteRepository favoriteRepository;

  NetworkCatRepository(this.favoriteRepository);

  @override
  Future<List<Cat>> getCats([int page = 0]) async {
    final catResponse = await _apiClient.fetchCatsResponse(page);
    final factResponse = await _apiClient.fetchFactResponse();
    final catFavorite = await favoriteRepository.getAllCat();
    //Todo: rewrite important its bad
    List<Cat> cats = [];
    for (var i = 0; i < 10; i++) {
      cats.add(Cat(
        id: catResponse[i].id,
        imagUrl: catResponse[i].imgUrl,
        catFact: factResponse[i].fact,
      ));
    }
    cats.forEach((element) {
      for (var cat in catFavorite) {
        if (element.id == cat.id) {
          element.saved = true;
        }
      }
    });
    return cats;
  }

  
}
