import 'package:animal_crossing_helper/redux/fish/fish_state.dart';
import 'package:animal_crossing_helper/redux/insect/insect_state.dart';

class AppState {
  FishState fish;
  InsectState insects;

  AppState({this.fish, this.insects});

  factory AppState.initial() =>
    AppState(
      fish: FishState.initial(),
      insects: InsectState.initial(),
    );

  @override
  int get hashCode =>
    fish.hashCode ^ insects.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AppState &&
    runtimeType == other.runtimeType &&
    fish == other.fish &&
    insects == other.insects;

  @override
  String toString() {
    return 'AppState{fish: $fish, insects: $insects}';
  }
}