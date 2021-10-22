const String _apiKey = '0b332e15-6f0e-4b54-b624-ea5c0a9dcdfa';

class CatApiClient {
  Map<String, String> headers = {'x-api-key' : _apiKey,};
  Uri uri = Uri(
    scheme: 'https',
    host: 'api.thecatapi.com',
    path: '/v1/images/search',
  );
}
