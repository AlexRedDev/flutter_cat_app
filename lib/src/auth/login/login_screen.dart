import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app/app_bloc.dart';
import 'package:flutter_cat_app/src/auth/auth_navigator_cubit.dart';
import 'package:flutter_cat_app/src/auth/login/login_bloc.dart';
import 'package:flutter_cat_app/src/auth/login/login_event.dart';
import 'package:flutter_cat_app/src/auth/login/login_state.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'package:flutter_cat_app/src/auth/submission_status.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

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
                  _authMethod(context),
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.error);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usernameTextFormField(),
            _passwordTextFormField(),
            _loginButton()
          ],
        ),
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
            validator: (_) => state.isValidPassword ? null : 'short password',
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

  Widget _authMethod(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () =>
                    context.read<LoginBloc>().add(SignInWithGoogle()),
                child: Text('Google')),
            TextButton(
                onPressed: () =>
                    context.read<LoginBloc>().add(SignInWithFacebook()),
                child: Text('Facebook')),
          ],
        );
      },
    );
  }

  Widget _signUpButton(BuildContext context) {
    return TextButton(
        onPressed: () => context.read<AuthNavigatorCubit>().showSignUpScreen(),
        child: Text('I dont have account'));
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate())
                    context.read<LoginBloc>().add(SignInWithCredentials());
                },
                child: Text('Login'),
              );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
