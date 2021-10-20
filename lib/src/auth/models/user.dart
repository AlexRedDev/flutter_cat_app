import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String? name;
  final String? photo;

  const User({
    required this.email,
    this.name,
    this.photo,
  });

  static const empty = User(email: '');

  @override
  List<Object?> get props => [email, name, photo];
}
