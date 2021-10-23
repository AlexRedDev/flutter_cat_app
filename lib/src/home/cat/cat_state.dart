import 'package:equatable/equatable.dart';
import 'package:flutter_cat_app/src/home/models/cat.dart';

enum CatStatus {
  initial,
  succes,
  failure,
}

class CatState extends Equatable {
  final CatStatus status;
  final List<Cat> cats;
  final bool hasReachedMax;

  const CatState({
    this.status = CatStatus.initial,
    this.cats = const [],
    this.hasReachedMax = false,
  });

  CatState copyWith({
    CatStatus? status,
    List<Cat>? cats,
    bool? hasReachedMax,
  }) {
    return CatState(
      status: status ?? this.status,
      cats: cats ?? this.cats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, cats, hasReachedMax];
}
