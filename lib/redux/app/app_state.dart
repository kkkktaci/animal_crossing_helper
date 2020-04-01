import 'dart:convert';

import 'package:animal_crossing_helper/redux/animal/animal_state.dart';
import 'package:animal_crossing_helper/redux/fish/fish_state.dart';
import 'package:animal_crossing_helper/redux/insect/insect_state.dart';

class AppState {
  FishState fish;
  InsectState insects;
  AnimalState animal;

  AppState({this.fish, this.insects, this.animal});

  factory AppState.initial() =>
    AppState(
      fish: FishState.initial(),
      insects: InsectState.initial(),
      animal: AnimalState.initial(),
    );

  @override
  int get hashCode =>
    fish.hashCode ^ insects.hashCode ^ animal.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AppState &&
    runtimeType == other.runtimeType &&
    fish == other.fish &&
    insects == other.insects &&
    animal == other.animal;

  // for redux persist
  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState.initial();
    }
    var fishS = jsonDecode(json['fish']);
    print(fishS);
    return AppState(
      fish: FishState.fromJson(jsonDecode(json['fish'])),
      insects: InsectState.fromJson(jsonDecode(json['insects'])),
      animal: AnimalState.fromJson(jsonDecode(json['animal']))
    );
  }

  // for redux persist
  dynamic toJson() => {'fish': fish.toJson(), 'insects': insects.toJson(), 'animal': animal.toJson()};

  @override
  String toString() {
    return 'AppState{fish: $fish, insects: $insects}, animal: $animal';
  }
}