import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app_navigator.dart';
import 'package:flutter_cat_app/src/app_state.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';

import 'app_bloc.dart';
import 'auth/models/user.dart';

class App extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();
  App({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RepositoryProvider(
      create: (context) => authRepository,
      child: BlocProvider(
        create: (context) => AppBloc(
            authRepository: authRepository,
            state: authRepository.isAuthenticated()
                ? Authenticated(user: User(email: ''))
                : Unauthenticated()),
        child: AppNavigator(),
      ),
    ));
  }
}
