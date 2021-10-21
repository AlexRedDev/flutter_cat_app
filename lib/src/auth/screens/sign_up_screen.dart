import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/auth/auth_navigator_cubit.dart';
import 'package:flutter_cat_app/src/auth/bloc/sign_up_bloc.dart';
import 'package:flutter_cat_app/src/auth/bloc/sign_up_event.dart';
import 'package:flutter_cat_app/src/auth/bloc/sign_up_state.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            SignUpBloc(authRepository: context.read<AuthRepository>()),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _form(context),
              _signInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _emailTextField(),
        _passwordTextField(),
        _signUpButton(context),
      ],
    );
  }

  Widget _emailTextField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) =>
              context.read<SignUpBloc>().add(EmailChanged(value)),
          validator: (_) => state.isValidEmail ? null : 'Email is invalid',
          decoration: const InputDecoration(
            label: Text('Email'),
            icon: Icon(Icons.person),
          ),
        );
      },
    );
  }

  Widget _passwordTextField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          onChanged: (value) =>
              context.read<SignUpBloc>().add(PasswordChanded(value)),
          validator: (_) => state.isValidPassword ? null : 'Password to short',
          decoration: const InputDecoration(
            label: Text('Password'),
            icon: Icon(Icons.security),
          ),
        );
      },
    );
  }

  Widget _signUpButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () =>
            context.read<SignUpBloc>().add(RegistrateAndAuthorization()),
        child: Text('Sign Up'));
  }

  Widget _signInButton(BuildContext context) {
    return TextButton(
        onPressed: () => context.read<AuthNavigatorCubit>().showLoginScreen(),
        child: Text('I have account. Sign In.'));
  }
}
