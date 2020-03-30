import 'package:animal_crossing_helper/redux/insect/insect_actions.dart';
import 'package:animal_crossing_helper/redux/insect/insect_state.dart';
import 'package:redux/redux.dart';

InsectState _onFetch(InsectState state, FetchInsectsStart action) =>
  state.copyWith(insects: state.insects, fetching: true, error: null);

InsectState _onDone(InsectState state, FetchInsectsDone action) =>
  state.copyWith(insects: action.data, fetching: false, error: null);

InsectState _onError(InsectState state, FetchInsectsError action) =>
  state.copyWith(insects: state.insects, fetching: false, error: action.error);

final insectReducer = combineReducers<InsectState>([
  TypedReducer<InsectState, FetchInsectsStart>(_onFetch),
  TypedReducer<InsectState, FetchInsectsDone>(_onDone),
  TypedReducer<InsectState, FetchInsectsError>(_onError),
]);