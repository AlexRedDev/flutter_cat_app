import 'package:flutter/material.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_bloc.dart';
import 'package:flutter_cat_app/src/auth/bloc/login_event.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const Image(
                      height: 300,
                      width: 300,
                      image: AssetImage('assets/images/cat_logo.jpg')),
                ),
                _form(),
                _loginButton(),
                _auth(context),
              ],
            ),
            _signUpButton(),
          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          label: Text('Username'),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _passwordTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          label: Text('Password'),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _auth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () => context.read<LoginBloc>().add(SignInWithGoogle()),
            child: Text('Google')),
        TextButton(onPressed: () {}, child: Text('Facebook')),
      ],
    );
  }

  Widget _signUpButton() {
    return TextButton(onPressed: () {}, child: Text('I dont have account'));
  }

  Widget _loginButton() {
    return ElevatedButton(onPressed: () {}, child: Text('Login'));
  }
}
