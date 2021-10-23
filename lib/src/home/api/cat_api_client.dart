import 'dart:convert';
import 'package:flutter_cat_app/src/home/models/cat.dart';
import 'package:flutter_cat_app/src/home/models/cat_response.dart';
import 'package:flutter_cat_app/src/home/models/fact_response.dart';
import 'package:http/http.dart' as http;

const String _apiKey = '0b332e15-6f0e-4b54-b624-ea5c0a9dcdfa';
const String _schemeUri = 'https';
const String _hostCat = '';
const String _hostFact = '';
const String _pathCat = '';
const String _pathFact = '';

class CatApiClient {
  Future<List<Cat>> fetchCat([int page = 0]) async {
    final catResponse = await _fetchCatsResponse(page);
    final factResponse = await _fetchFactResponse();
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

  Future<List<CatResponse>> _fetchCatsResponse([int page = 0]) async {
    Map<String, String> headers = {
      'x-api-key': _apiKey,
    };
    Uri uri = Uri(
        scheme: _schemeUri,
        host: 'api.thecatapi.com',
        path: '/v1/images/search',
        queryParameters: {
          'limit': '10',
          'page': page.toString(),
        });

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final catsResponse =
          body.map<CatResponse>((json) => CatResponse.fromJson(json)).toList();
      return catsResponse;
    } else {
      throw Exception();
    }
  }

  Future<List<FactResponse>> _fetchFactResponse() async {
    Uri uri = Uri(
        scheme: _schemeUri,
        host: 'catfact.ninja',
        path: 'facts',
        queryParameters: {
          'limit': '10',
        });

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final factsResponse = body['data']
          .map<FactResponse>((json) => FactResponse.fromJson(json))
          .toList();
      return factsResponse;
    } else {
      throw Exception();
    }
  }
}
