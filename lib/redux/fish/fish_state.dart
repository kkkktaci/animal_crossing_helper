import 'package:animal_crossing_helper/models/catchable.dart';

class FishState {
  final List<Catchable> fish;
  final bool fetching;
  final Object error;

  FishState({this.fish, this.fetching, this.error});

  factory FishState.initial() =>
    FishState(
      fish: List<Catchable>(),
      fetching: false,
      error: null
    );

  FishState copyWith({List<Catchable> fish, bool fetching, Object error}) {
    return FishState(fish: fish, fetching: fetching, error: error);
  }

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is FishState &&
      runtimeType == other.runtimeType &&
      fish == other.fish &&
      fetching == other.fetching &&
      error == other.error;
  
  @override
  int get hashCode =>
    fish.hashCode ^ fetching.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'FishState{fish: $fish, fetching: $fetching, error: $error}';
  }
}