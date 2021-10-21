import 'package:flutter/material.dart';
import 'package:flutter_cat_app/src/app_bloc.dart';
import 'package:flutter_cat_app/src/app_event.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon), label: 'Cat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Authenticated'),
            TextButton(
                onPressed: () =>
                    context.read<AppBloc>().add(AppLogoutRequest()),
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
