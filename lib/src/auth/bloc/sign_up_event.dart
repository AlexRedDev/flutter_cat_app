abstract class SignUpEvent {}

class EmailChanged extends SignUpEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanded extends SignUpEvent {
  final String password;
  PasswordChanded(this.password);
}

class RegistrateAndAuthorization extends SignUpEvent {}
