import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/fish/fish_actions.dart';
import 'package:animal_crossing_helper/redux/fish/fish_state.dart';

FishState _onFetch(FishState state, FetchFishStart action) =>
  state.copyWith(fish: state.fish, fetching: true, error: null);

FishState _onDone(FishState state, FetchFishDone action) =>
  state.copyWith(fish: action.data, fetching: false, error: null);

FishState _onError(FishState state, FetchFishError action) =>
  state.copyWith(fish: state.fish, fetching: false, error: action.error);

final fishReducer = combineReducers<FishState>([
  TypedReducer<FishState, FetchFishStart>(_onFetch),
  TypedReducer<FishState, FetchFishDone>(_onDone),
  TypedReducer<FishState, FetchFishError>(_onError),
]);