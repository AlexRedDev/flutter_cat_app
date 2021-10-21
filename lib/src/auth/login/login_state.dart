import 'package:email_validator/email_validator.dart';
import 'package:flutter_cat_app/src/auth/submission_status.dart';

class LoginState {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidEmail => EmailValidator.validate(email);
  bool get isValidPassword => password.length >= 6;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
