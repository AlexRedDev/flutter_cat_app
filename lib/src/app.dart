import 'package:flutter/material.dart';
import 'package:flutter_cat_app/src/auth/auth_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthView(),
    );
  }
}
