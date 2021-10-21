import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/auth/login/login_screen.dart';
import 'package:flutter_cat_app/src/auth/sign_up/sign_up_screen.dart';

import 'auth_navigator_cubit.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthNavigatorCubit, AuthState>(
      builder: (context, state) {
        return Navigator(pages: [
          if (state == AuthState.login)
            MaterialPage(child: LoginScreen()),
          if (state == AuthState.signUp)
            MaterialPage(child: SignUpScreen()),
        ], onPopPage: (route, result) => route.didPop(result));
      },
    );
  }
}
