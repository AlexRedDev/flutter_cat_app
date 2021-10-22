import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app_navigator.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'app/app_bloc.dart';
import 'app/app_state.dart';

class App extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => authRepository,
        child: BlocProvider(
          create: (context) => AppBloc(
              authRepository: authRepository,
              state: authRepository.isAuthenticated()
                  ? Authenticated(user: authRepository.getUser())
                  : Unauthenticated()),
          child: const AppNavigator(),
        ),
      ),
    );
  }
}
