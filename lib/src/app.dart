import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'package:flutter_cat_app/src/auth/screens/login_screen.dart';

import 'auth/bloc/login_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) => LoginBloc(authRepository: AuthRepository()),
      child: LoginScreen(),
    ));
  }
}
