import 'package:animal_crossing_helper/models/catchable.dart';

class InsectState {
  final List<Catchable> insects;
  final bool fetching;
  final Object error;

  InsectState({this.insects, this.fetching, this.error});

  factory InsectState.initial() =>
    InsectState(
      insects: List<Catchable>(),
      fetching: false,
      error: null
    );

  InsectState copyWith({List<Catchable> insects, bool fetching, Object error}) {
    return InsectState(insects: insects, fetching: fetching, error: error);
  }

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is InsectState &&
      runtimeType == other.runtimeType &&
      insects == other.insects &&
      fetching == other.fetching &&
      error == other.error;
  
  @override
  int get hashCode =>
    insects.hashCode ^ fetching.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'FishState{fish: $insects, fetching: $fetching, error: $error}';
  }
}