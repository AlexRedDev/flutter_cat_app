import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/app/app_bloc.dart';
import 'package:flutter_cat_app/src/auth/repository/auth_repository.dart';
import 'package:flutter_cat_app/src/auth/submission_status.dart';

import '../auth_navigator_cubit.dart';
import 'sign_up_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(
          authRepository: context.read<AuthRepository>(),
          appBloc: context.read<AppBloc>(),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _form(context),
              _showLoginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final status = state.formStatus;
        if (status is SubmissionFailed) {
          _showSnackBar(context, status.exception);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _emailTextField(),
            _passwordTextField(),
            _signUpButton(context),
          ],
        ),
      ),
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpBloc>().add(SignUpSubmitted());
                  }
                },
                child: const Text('Sign Up'));
      },
    );
  }

  Widget _showLoginButton(BuildContext context) {
    return TextButton(
        onPressed: () => context.read<AuthNavigatorCubit>().showLoginScreen(),
        child: const Text('I have account. Sign In.'));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
