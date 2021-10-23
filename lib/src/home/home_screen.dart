import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/cat/cat_event.dart';
import 'package:flutter_cat_app/src/home/cat/cat_screen.dart';
import 'package:flutter_cat_app/src/home/favorite/favorite_screen.dart';
import 'package:flutter_cat_app/src/home/favorite/favorite_state.dart';
import 'package:flutter_cat_app/src/home/home_navigator_cubit.dart';
import 'package:flutter_cat_app/src/home/profile/profile_screen.dart';
import 'package:flutter_cat_app/src/home/repository/cat_repository.dart';

import 'cat/cat_bloc.dart';
import 'favorite/favorite_cubit.dart';
import 'models/cat.dart';

final List<Cat> cats = [
  Cat(id: '1', imagUrl: '1', catFact: '1'),
  Cat(id: '2', imagUrl: '2', catFact: '2'),
  Cat(id: '3', imagUrl: '3', catFact: '3'),
  Cat(id: '4', imagUrl: '4', catFact: '4'),
  Cat(id: '5', imagUrl: '5', catFact: '5'),
  Cat(id: '6', imagUrl: '6', catFact: '6'),
  Cat(id: '7', imagUrl: '7', catFact: '7'),
  Cat(id: '8', imagUrl: '8', catFact: '8'),
  Cat(id: '9', imagUrl: '9', catFact: '9'),
];

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
                    CatBloc(repository: CatRepository())..add(CatFetched()),
                child: CatScreen(),
              );
            case HomeState.favorite:
              return BlocProvider(
                create: (context) => FavoriteCubit(FavoriteState(cats: cats)),
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
