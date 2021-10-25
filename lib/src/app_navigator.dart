import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/auth/auth_navigator.dart';
import 'app/app_bloc.dart';
import 'app/app_state.dart';
import 'auth/auth_navigator_cubit.dart';
import 'home/home_navigator_cubit.dart';
import 'home/home_navigator.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is Unauthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => AuthNavigatorCubit(),
                  child: const AuthNavigator(),
                ),
              ),
            if (state is Authenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => HomeNavigatorCubit(),
                  child: HomeNavigator(),
                ),
              )
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
