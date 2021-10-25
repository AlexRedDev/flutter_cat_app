import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cat.g.dart';

@HiveType(typeId: 0)
class Cat extends Equatable{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String imagUrl;
  @HiveField(2)
  final String catFact;
  @HiveField(3)
  bool saved;

  Cat({
    required this.id,
    required this.imagUrl,
    required this.catFact,
    this.saved = false,
  });

  @override
  List<Object?> get props => [id, imagUrl, catFact, saved];
}
