import 'package:flutter/material.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';
import 'package:provider/src/provider.dart';

import '../cat_bloc.dart';
import '../cat_event.dart';

class CatItem extends StatelessWidget {
  final Cat cat;
  const CatItem({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'cat',
          child: Image.network(
            cat.imagUrl,
            fit: BoxFit.cover,
            height: 120,
            width: 180,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () =>
                    context.read<CatBloc>().add(AddToFavorite(cat)),
                icon: cat.saved
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_outline, color: Colors.grey)),
          ],
        ),
      ],
    );;
  }
}
