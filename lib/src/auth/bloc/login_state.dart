class LoginState {
  final String email;
  final String password;

  bool get isValidEmail => email.contains('@');
  bool get isValidPassword => password.length > 6;

  LoginState({
    this.email = '',
    this.password = '',
  });

  LoginState copyWith({String? email, String? password}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
