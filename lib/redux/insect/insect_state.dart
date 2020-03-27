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

  factory InsectState.fetching() =>
    InsectState(
      insects: List<Catchable>(),
      fetching: true,
      error: null
    );

  factory InsectState.error(Object error) =>
    InsectState(
      insects: List<Catchable>(),
      fetching: false,
      error: error
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