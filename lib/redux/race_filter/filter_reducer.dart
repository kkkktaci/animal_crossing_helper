import 'package:animal_crossing_helper/redux/race_filter/filter_actions.dart';
import 'package:animal_crossing_helper/redux/race_filter/filter_state.dart';
import 'package:redux/redux.dart';

RaceFilterState _onUpdateRace(RaceFilterState state, UpdateRaceFilter action) {
  if (action.race == null) {
    // 重置filter
    return RaceFilterState.initial();
  }
  return RaceFilterState(selected: action.race);
}

final raceFilterReducer = combineReducers<RaceFilterState>([
  TypedReducer<RaceFilterState, UpdateRaceFilter>(_onUpdateRace),
]);
