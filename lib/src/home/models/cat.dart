import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class Cat {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String imagUrl;
  @HiveField(2)
  final String catFact;
  @HiveField(3)
  final bool saved;

  Cat({
    required this.id,
    required this.imagUrl,
    required this.catFact,
    this.saved = false,
  });
}
