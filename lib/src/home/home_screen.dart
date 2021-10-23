import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/cat/repository/network_cat_repository.dart';
import 'package:flutter_cat_app/src/home/favorite/favorite_screen.dart';
import 'package:flutter_cat_app/src/home/home_navigator_cubit.dart';
import 'package:flutter_cat_app/src/home/profile/profile_screen.dart';

import 'favorite/favorite_cubit.dart';
import 'favorite/repository/cached_favorite_repository.dart';
import 'cat/cat_bloc.dart';
import 'cat/cat_event.dart';
import 'cat/cat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeNavigatorCubit, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeState.home:
              return BlocProvider(
                create: (context) =>
                    CatBloc(repository: NetworkCatRepository())..add(CatFetched()),
                child: CatScreen(),
              );
            case HomeState.favorite:
              return BlocProvider(
                create: (context) => FavoriteCubit(
                    favoriteRepository: CachedFavoriteRepository())
                  ..loadFavorite(),
                child: FavoriteScreen(),
              );
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
