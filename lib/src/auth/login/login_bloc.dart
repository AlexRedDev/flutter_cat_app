import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app/app_bloc.dart';
import 'package:flutter_cat_app/src/app/app_event.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';

import '../submission_status.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AppBloc appBloc;

  LoginBloc({required this.authRepository, required this.appBloc})
      : super(LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignInWithCredentials>(_onSignInWithCredentials);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInWithFacebook>(_onSignInWithFacebook);
  }
  void _onEmailChanged(
    EmailChanged event,
    Emitter<LoginState> emit,
  ) =>
      emit(state.copyWith(
          email: event.email, formStatus: const InitialFormStatus()));

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) =>
      emit(state.copyWith(
          password: event.password, formStatus: const InitialFormStatus()));

  Future<void> _onSignInWithCredentials(
    SignInWithCredentials event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      final user = await authRepository.signInWithCredentials(
        email: state.email,
        password: state.password,
      );

      emit(state.copyWith(formStatus: SubmissionSuccess()));
      appBloc.add(AppUserChanged(user: user));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
    }
  }
  //Todo: cath PlatformNullException
  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(formStatus: FormSubmitting()));
      final user = await authRepository.signInWithGoogle();
      emit(state.copyWith(formStatus: SubmissionSuccess()));
      appBloc.add(AppUserChanged(user: user));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
    }
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebook event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(formStatus: FormSubmitting()));
      final user = await authRepository.signInWithFacebook();
      emit(state.copyWith(formStatus: SubmissionSuccess()));
      appBloc.add(AppUserChanged(user: user));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
    }
  }
}
