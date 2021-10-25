import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cat_bloc.dart';
import 'cat_event.dart';
import 'cat_state.dart';
import 'widget/cat_item.dart';

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
      body: BlocBuilder<CatBloc, CatsState>(
        builder: (context, state) {
          if (state is CatsFailure) {
            return Center(child: Text(state.error));
          } else if (state is CatsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatsLoaded) {
            return catList(state);
          } else {
            return Text('else');
          }
        },
      ),
    );
  }

  GridView catList(CatsLoaded state) {
      return GridView.builder(
        controller: _scrollController,
        itemCount:
            state.hasReachedMax ? state.cats.length : state.cats.length + 1,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return index >= state.cats.length
              ? Center(child: const CircularProgressIndicator())
              : CatItem(cat: state.cats[index]);
        },
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
    if (_isBottom) context.read<CatBloc>().add(FetchCats());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentSrcoll = _scrollController.offset;
    return currentSrcoll >= (maxScroll * 0.9);
  }
}
