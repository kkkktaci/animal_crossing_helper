import 'dart:convert';

import 'package:animal_crossing_helper/models/animal.dart';

class AnimalState {
  final List<Animal> animal;
  final bool fetching;
  final Object error;
  final Object detailError;

  AnimalState({this.animal, this.fetching, this.error, this.detailError});

  factory AnimalState.initial() =>
    AnimalState(
      animal: List<Animal>(),
      fetching: false,
      error: null,
      detailError: null
    );

  AnimalState copyWith({List<Animal> animal, bool fetching, Object error, Object detailError}) {
    return AnimalState(animal: animal, fetching: fetching, error: error, detailError: detailError);
  }

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AnimalState &&
      runtimeType == other.runtimeType &&
      animal == other.animal &&
      fetching == other.fetching &&
      error == other.error &&
      detailError == other.detailError;
  
  @override
  int get hashCode =>
    animal.hashCode ^ fetching.hashCode ^ error.hashCode ^ detailError;

  @override
  String toString() {
    return 'FishState{fish: $animal, fetching: $fetching, error: $error, detailError: $detailError}';
  }

  factory AnimalState.fromJson(Map<String, dynamic> json) {
    var animal = List<Animal>.from(json['animal'].map((i) => Animal.fromJson(i)));
    return AnimalState(animal: animal, fetching: false, error: null, detailError: null);
  }
  dynamic toJson() => jsonEncode({'animal': animal});
}