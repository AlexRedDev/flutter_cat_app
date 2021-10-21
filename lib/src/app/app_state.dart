import 'package:firebase_auth/firebase_auth.dart';

abstract class AppState {}

class Unauthenticated extends AppState {}

class Authenticated extends AppState {
  final User user;

  Authenticated({required this.user});
}
