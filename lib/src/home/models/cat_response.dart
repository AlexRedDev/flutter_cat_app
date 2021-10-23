class CatResponse {
  final String id;
  final String imgUrl;

  CatResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imgUrl = json['url'];
}
