import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState {
  login,
  signUp,
}

class AuthNavigatorCubit extends Cubit<AuthState> {
  AuthNavigatorCubit() : super(AuthState.login);

  void showLoginScreen() => emit(AuthState.login);
  void showSignUpScreen() => emit(AuthState.signUp);
}
