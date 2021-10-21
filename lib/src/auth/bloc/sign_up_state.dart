class SignUpState {
  final String email;
  final String password;

  bool get isValidEmail => email.contains('@');
  bool get isValidPassword => password.length > 6;

  SignUpState({
    this.email = '',
    this.password = '',
  });

  SignUpState copyWith({String? email, String? password}) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
