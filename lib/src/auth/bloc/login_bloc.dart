import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app_event.dart';
import 'package:flutter_cat_app/src/app_state.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_event.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_state.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'package:flutter_cat_app/src/auth/models/user.dart' as native;

import '../../app_bloc.dart';

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
      emit(state.copyWith(email: event.email));

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) =>
      emit(state.copyWith(password: event.password));

  Future<void> _onSignInWithCredentials(
    SignInWithCredentials event,
    Emitter<LoginState> emit,
  ) async {
    final user = await authRepository.signInWithCredentials(
      email: state.email,
      password: state.password,
    );
    if (user != null) {
      final profielUser = native.User(
        email: user.email ?? '',
        name: user.displayName,
        photo: user.photoURL,
      );
      appBloc.add(AppUserChanged(user: profielUser));
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    authRepository.signInWithGoogle();
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebook event,
    Emitter<LoginState> emit,
  ) async {
    authRepository.signOut();
  }
}
