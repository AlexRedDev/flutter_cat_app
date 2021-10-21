import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeState {
  home,
  favorite,
  profile,
}

class HomeNavigatorCubit extends Cubit<HomeState> {
  HomeNavigatorCubit() : super(HomeState.home);

  int currentIndex = 0;
  void showScreen(int index) {
    switch (index) {
      case 0:
        emit(HomeState.home);
        break;
      case 1:
        emit(HomeState.favorite);
        break;
      case 2:
        emit(HomeState.profile);
        break;
    }
  }
}
