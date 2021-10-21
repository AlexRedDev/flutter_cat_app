import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app_bloc.dart';
import 'package:flutter_cat_app/src/auth/auth_navigator_cubit.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_bloc.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_event.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_state.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: true,
        create: (context) => LoginBloc(
          authRepository: context.read<AuthRepository>(),
          appBloc: context.read<AppBloc>(),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _form(),
                  _loginButton(context),
                  _auth(context),
                ],
              ),
              _signUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _usernameTextFormField(),
          _passwordTextFormField(),
        ],
      ),
    );
  }

  Widget _usernameTextFormField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TextFormField(
            validator: (value) => state.isValidEmail ? null : 'Email invalid',
            onChanged: (value) =>
                context.read<LoginBloc>().add(EmailChanged(value)),
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              label: Text('Username'),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }

  Widget _passwordTextFormField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TextFormField(
            obscureText: true,
            validator: (value) =>
                state.isValidPassword ? null : 'short password',
            onChanged: (value) =>
                context.read<LoginBloc>().add(PasswordChanged(value)),
            decoration: const InputDecoration(
              icon: Icon(Icons.security),
              label: Text('Password'),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }

  Widget _auth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () => context.read<LoginBloc>().add(SignInWithGoogle()),
            child: Text('Google')),
        TextButton(
            onPressed: () =>
                context.read<LoginBloc>().add(SignInWithFacebook()),
            child: Text('Facebook')),
      ],
    );
  }

  Widget _signUpButton(BuildContext context) {
    return TextButton(
        onPressed: () => context.read<AuthNavigatorCubit>().showSignUpScreen(),
        child: Text('I dont have account'));
  }

  Widget _loginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () =>
                context.read<LoginBloc>().add(SignInWithCredentials()),
            child: Text('Login'));
      },
    );
  }
}
