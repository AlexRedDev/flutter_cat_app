import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app_event.dart';
import 'package:flutter_cat_app/src/app_state.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'package:http/http.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository authRepository;

  AppBloc({required this.authRepository})
      : super(const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequest>(_onLogoutRequest);
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {}

  void _onLogoutRequest(AppLogoutRequest event, Emitter<AppState> emit) {}
}
