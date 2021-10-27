import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AppState {}

class Authenticated extends AppState {
  final User user;
  Authenticated({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
