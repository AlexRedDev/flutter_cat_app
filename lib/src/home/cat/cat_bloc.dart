import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cat_app/src/home/cat/repository/cat_repository.dart';

import 'cat_event.dart';
import 'cat_state.dart';

const throttleDuration = Duration(seconds: 1);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttleTime(duration), mapper);
  };
}

class CatBloc extends Bloc<CatEvent, CatState> {
  int _page = 1;
  final CatRepository repository;
  CatBloc({required this.repository}) : super(const CatState()) {
    on<CatFetched>(
      _onCatFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onCatFetched(CatFetched event, Emitter<CatState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CatStatus.initial) {
        final cats = await repository.getCats();

        emit(state.copyWith(
          status: CatStatus.succes,
          cats: cats,
          hasReachedMax: false,
        ));
      }
      final cats = await repository.getCats(_page);
      emit(cats.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: CatStatus.succes,
              cats: List.of(state.cats)..addAll(cats),
              hasReachedMax: false,
            ));
      _page++;
    } catch (e) {
      emit(state.copyWith(status: CatStatus.failure));
    }
  }
}
