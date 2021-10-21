import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AppEvent extends Equatable {}

class AppLogoutRequest extends AppEvent {
  @override
  List<Object?> get props => [];
}

class AppUserChanged extends AppEvent {
  final User user;

  AppUserChanged({required this.user});
  @override
  List<Object?> get props => [user];
}
