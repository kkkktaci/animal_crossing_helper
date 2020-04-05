import 'dart:convert';

import 'package:animal_crossing_helper/redux/animal/animal_state.dart';
import 'package:animal_crossing_helper/redux/filters/filter_state.dart';
import 'package:animal_crossing_helper/redux/fish/fish_state.dart';
import 'package:animal_crossing_helper/redux/insect/insect_state.dart';
import 'package:animal_crossing_helper/redux/location/location_state.dart';

class AppState {
  FishState fish;
  InsectState insects;
  AnimalState animal;
  LocationState location;
  FilterState filters;

  AppState({this.fish, this.insects, this.animal, this.location, this.filters});

  factory AppState.initial() =>
    AppState(
      fish: FishState.initial(),
      insects: InsectState.initial(),
      animal: AnimalState.initial(),
      location: LocationState.initial(),
      filters: FilterState.initial()
    );

  @override
  int get hashCode =>
    fish.hashCode ^ insects.hashCode ^ animal.hashCode ^ location.hashCode ^ filters.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AppState &&
    runtimeType == other.runtimeType &&
    fish == other.fish &&
    insects == other.insects &&
    animal == other.animal &&
    location == other.location &&
    filters == other.filters;

  // for redux persist
  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState.initial();
    }

    // 后续版本中加入的, 老版本json中不存在会报错
    var location;
    try {
      var j = jsonDecode(json['location']);
      location = LocationState.fromjson(j);
    } catch (e) {
      location = LocationState.initial();
    }
    return AppState(
      fish: FishState.fromJson(jsonDecode(json['fish'])),
      insects: InsectState.fromJson(jsonDecode(json['insects'])),
      animal: AnimalState.fromJson(jsonDecode(json['animal'])),
      location: location,
      filters: FilterState.initial()
    );
  }

  // for redux persist
  dynamic toJson() =>
    {'fish': fish.toJson(), 'insects': insects.toJson(), 'animal': animal.toJson(), 'location': location.toJson()};

  @override
  String toString() {
    return 'AppState{filter: $filters, location: $location, fish: $fish, insects: $insects, animal: $animal}';
  }
}