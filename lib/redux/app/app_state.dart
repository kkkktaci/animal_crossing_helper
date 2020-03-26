import 'package:animal_crossing_helper/redux/fish/fish_state.dart';

class AppState {
  FishState fish;

  AppState({this.fish});

  factory AppState.initial() =>
    AppState(
      fish: FishState.initial()
    );

  @override
  int get hashCode =>
    fish.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AppState &&
    runtimeType == other.runtimeType &&
    fish == other.fish;

  @override
  String toString() {
    return 'AppState{fish: $fish}';
  }
}