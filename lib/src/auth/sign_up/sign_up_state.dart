import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cat_app/src/auth/submission_status.dart';

class SignUpState extends Equatable {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidEmail => EmailValidator.validate(email);
  bool get isValidPassword => password.length > 6;

  const SignUpState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignUpState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [email, password, formStatus];
}
