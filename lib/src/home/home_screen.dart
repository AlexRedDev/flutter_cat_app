import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/cat/cat_screen.dart';
import 'package:flutter_cat_app/src/home/favorite/favorite_screen.dart';
import 'package:flutter_cat_app/src/home/home_navigator_cubit.dart';
import 'package:flutter_cat_app/src/home/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeNavigatorCubit, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeState.home:
              return CatScreen();
            case HomeState.favorite:
              return FavoriteScreen();
            case HomeState.profile:
              return ProfileScreen();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeNavigatorCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: context.select((value) => state.index),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.catching_pokemon), label: 'Cat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            onTap: (index) =>
                context.read<HomeNavigatorCubit>().showScreen(index),
          );
        },
      ),
    );
  }
}
