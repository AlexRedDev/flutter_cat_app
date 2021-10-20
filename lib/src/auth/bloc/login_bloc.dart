import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_event.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_state.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState()) {
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
      emit(state.copyWith(password: event.email));

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) =>
      emit(state.copyWith(password: event.password));

  Future<void> _onSignInWithCredentials(
    SignInWithCredentials event,
    Emitter<LoginState> emit,
  ) async {}

  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    authRepository.signInWithGoogle();
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebook event,
    Emitter<LoginState> emit,
  ) async {}
}
