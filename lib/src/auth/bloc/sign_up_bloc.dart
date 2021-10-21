import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/auth/bloc/sign_up_event.dart';
import 'package:flutter_cat_app/src/auth/bloc/sign_up_state.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepository authRepository;
  
  SignUpBloc({required this.authRepository}) : super(SignUpState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanded>(_onPasswordChanged);
    on<RegistrateAndAuthorization>(_onRegistrateAndAuthorization);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(email: event.email));

  void _onPasswordChanged(PasswordChanded event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(password: event.password));

  Future<void> _onRegistrateAndAuthorization(
    RegistrateAndAuthorization event,
    Emitter<SignUpState> emit,
  ) async {
    authRepository.signUp(email: state.email, password: state.password);
  }
}
