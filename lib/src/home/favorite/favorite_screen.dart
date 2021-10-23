import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_cubit.dart';
import 'favorite_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.cats.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  state.cats[index].catFact,
                  maxLines: 2,
                ),
                trailing: GestureDetector(
                  onTap: () => context
                      .read<FavoriteCubit>()
                      .deleteFavorite(state.cats[index]),
                  child: state.cats[index].saved
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
