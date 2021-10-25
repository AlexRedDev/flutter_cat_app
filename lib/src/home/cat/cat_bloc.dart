import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_cat_app/src/home/favorite/repository/favorite_repository.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';
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

class CatBloc extends Bloc<CatEvent, CatsState> {
  final CatRepository catRepository;
  final FavoriteRepository favoriteRepository;
  int _page = 1;

  CatBloc({
    required this.catRepository,
    required this.favoriteRepository,
  }) : super(CatsInitial()) {
    on<FetchCats>(
      _onCatFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<AddToFavorite>(_onAddedFavorite);
    on<UpdateCats>(_onUpdateCats);
  }

  void _onCatFetched(
    FetchCats event,
    Emitter<CatsState> emit,
  ) async {
    try {
      if (state is CatsInitial) {
        emit(CatsLoading());

        final cats = await catRepository.getCats();
        emit(CatsLoaded(cats: cats));
      }
      if (state is CatsLoaded) {
        if ((state as CatsLoaded).hasReachedMax) return;
        final cats = await catRepository.getCats(_page);

        if (cats.isEmpty) {
          emit(CatsLoaded(hasReachedMax: true));
        } else {
          emit(CatsLoaded(
            cats: List.from((state as CatsLoaded).cats)..addAll(cats),
            hasReachedMax: false,
          ));
          _page++;
        }
      }
    } catch (e) {
      emit(CatsFailure(e.toString()));
    }
  }

  //Todo: add try cathc bloc
  void _onAddedFavorite(
    AddToFavorite event,
    Emitter<CatsState> emit,
  ) async {
    if (state is CatsLoaded) {
      final currentState = (state as CatsLoaded);
      final cats = List<Cat>.from(currentState.cats);

      for (var item in cats) {
        if (item.id == event.cat.id) {
          if (item.saved) {
            item.saved = false;
            break;
          } else {
            item.saved = true;
            break;
          }
        }
      }

      emit(CatsLoaded(
        cats: cats,
        hasReachedMax: currentState.hasReachedMax,
      ));
    }
  }

  void _onUpdateCats(UpdateCats event, Emitter<CatsState> emit) {
    if (state is CatsLoaded) {
      emit(state);
    }
  }
}
