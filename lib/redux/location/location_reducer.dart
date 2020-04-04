import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/location/location_actions.dart';
import 'package:animal_crossing_helper/redux/location/location_state.dart';

LocationState _onToggle(LocationState state, ToggleLocation action) {
  return LocationState(north: !state.north);
}

final locationReducer = combineReducers<LocationState>([
  TypedReducer<LocationState, ToggleLocation>(_onToggle),
]);