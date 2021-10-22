class Cat {
  final String imagUrl;
  final String catFact;

  Cat({
    required this.imagUrl,
    required this.catFact,
  });

  Cat.fromJson(Map<String, dynamic> json)
      : imagUrl = json['imageUrl'],
        catFact = json['catFact'];
}
