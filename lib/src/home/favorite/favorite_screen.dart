import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/favorite/favorite_event.dart';
import 'favorite_bloc.dart';
import 'favorite_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
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
                      .read<FavoriteBloc>()
                      .add(DeleteFavorite(state.cats[index])),
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
