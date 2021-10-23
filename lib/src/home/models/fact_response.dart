class FactResponse {
  final String fact;

  FactResponse.fromJson(Map<String, dynamic> json)
  :fact = json['fact'];
}
