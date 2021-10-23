import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/cat/cat_event.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';
import 'package:provider/provider.dart';

import 'cat_bloc.dart';
import 'cat_state.dart';

class CatScreen extends StatefulWidget {
  CatScreen({Key? key}) : super(key: key);

  @override
  _CatScreenState createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          switch (state.status) {
            case CatStatus.failure:
              return const Center(child: Text('error'));
            case CatStatus.succes:
              if (state.cats.isEmpty) {
                return const Center(child: Text('No Cats'));
              } else {
                return GridView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.cats.length
                      : state.cats.length + 1,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return index >= state.cats.length
                        ? const CircularProgressIndicator()
                        : CatItem(state.cats[index]);
                  },
                );
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget CatItem(Cat cat) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(cat: cat),
            ),
          ),
          child: Hero(
            tag: 'cat',
            child: Image.network(
              cat.imagUrl,
              fit: BoxFit.cover,
              height: 150,
              width: 180,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            cat.saved
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border, color: Colors.grey),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CatBloc>().add(CatFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentSrcoll = _scrollController.offset;
    return currentSrcoll >= (maxScroll * 0.9);
  }
}

class DetailsPage extends StatelessWidget {
  final Cat cat;
  const DetailsPage({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: 'cat',
                child: Image.network(cat.imagUrl),
              ),
              Text(cat.catFact),
            ],
          ),
        ),
      ),
    );
  }
}


// ListView.builder(
//                   itemCount: state.hasReachedMax
//                       ? state.cats.length
//                       : state.cats.length + 1,
//                   controller: _scrollController,
//                   itemBuilder: (BuildContext context, int index) {
//                     return index >= state.cats.length
//                         ? CircularProgressIndicator()
//                         : CatItem(state.cats[index]);
//                   },
//                 );