

import 'package:animal_crossing_helper/models/animal.dart';

class AnimalState {
  final List<Animal> animal;
  final bool fetching;
  final Object error;

  AnimalState({this.animal, this.fetching, this.error});

  factory AnimalState.initial() =>
    AnimalState(
      animal: List<Animal>(),
      fetching: false,
      error: null
    );

  factory AnimalState.fetching() =>
    AnimalState(
      animal: List<Animal>(),
      fetching: true,
      error: null
    );

  factory AnimalState.error(Object error) =>
    AnimalState(
      animal: List<Animal>(),
      fetching: false,
      error: error
    );

  AnimalState copyWith({List<Animal> animal, bool fetching, Object error}) {
    return AnimalState(animal: animal, fetching: fetching, error: error);
  }

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AnimalState &&
      runtimeType == other.runtimeType &&
      animal == other.animal &&
      fetching == other.fetching &&
      error == other.error;
  
  @override
  int get hashCode =>
    animal.hashCode ^ fetching.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'FishState{fish: $animal, fetching: $fetching, error: $error}';
  }
}