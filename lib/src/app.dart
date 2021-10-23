import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app_navigator.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'app/app_bloc.dart';
import 'app/app_state.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authRepo = context.read<AuthRepository>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AppBloc(
          authRepository: _authRepo,
          state: _authRepo.isAuthenticated()
              ? Authenticated(user: _authRepo.getUser())
              : Unauthenticated(),
        ),
        child: const AppNavigator(),
      ),
    );
  }
}
