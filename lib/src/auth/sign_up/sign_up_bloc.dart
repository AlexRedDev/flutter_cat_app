import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app/app_bloc.dart';
import 'package:flutter_cat_app/src/app/app_event.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'package:flutter_cat_app/src/auth/submission_status.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final AppBloc appBloc;

  SignUpBloc({
    required this.authRepository,
    required this.appBloc,
  }) : super(const SignUpState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanded>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(
          email: event.email, formStatus: const InitialFormStatus()));

  void _onPasswordChanged(PasswordChanded event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(
          password: event.password, formStatus: const InitialFormStatus()));

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      final user = await authRepository.signUp(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      appBloc.add(AppUserChanged(user: user));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
    }
  }
}
