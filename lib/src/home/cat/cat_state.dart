import 'package:equatable/equatable.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

abstract class CatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CatsInitial extends CatsState {}

class CatsLoading extends CatsState {}

class CatsLoaded extends CatsState {
  final List<Cat> cats;
  final bool hasReachedMax;

  CatsLoaded({
    this.cats = const [],
    this.hasReachedMax = false,
  });

  CatsLoaded copyWith({
    List<Cat>? cats,
    bool? hasReachedMax,
  }) {
    return CatsLoaded(
      cats: cats ?? this.cats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  List<Cat> cloneList() {
    return List<Cat>.from(cats);
  }

  @override
  List<Object?> get props => [cats, hasReachedMax];
}

class CatsNotLoaded extends CatsState {}

class CatsFailure extends CatsState {
  final String error;
  CatsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
