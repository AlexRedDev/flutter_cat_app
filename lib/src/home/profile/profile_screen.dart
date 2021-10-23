import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cat_app/src/app/app_event.dart';
import 'package:flutter_cat_app/src/app/app_state.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cat_app/src/app/app_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final state = appBloc.state;
    late User user;

    if (state is Authenticated) {
      user = state.user;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: user.photoURL != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(user.photoURL!))
                        : const Placeholder(),
                  ),
                  const SizedBox(height: 20),
                  Text(user.displayName ?? ''),
                  const SizedBox(height: 20),
                  Text(user.email ?? ''),
                ],
              ),
            ),
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
