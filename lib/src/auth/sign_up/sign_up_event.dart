import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailChanged extends SignUpEvent {
  final String email;
  EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanded extends SignUpEvent {
  final String password;
  PasswordChanded(this.password);

  @override
  List<Object?> get props => [password];
}

class SignUpSubmitted extends SignUpEvent {}
