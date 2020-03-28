import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:animal_crossing_helper/redux/animal/animal_state.dart';
import 'package:redux/redux.dart';

AnimalState _onFetch(AnimalState state, FetchAnimalListStart action) =>
  AnimalState.fetching();

AnimalState _onDone(AnimalState state, FetchAnimalListDone action) =>
  state.copyWith(animal: action.data, fetching: false, error: null);

AnimalState _onError(AnimalState state, FetchAnimalListError action) =>
  AnimalState.error(action.error);

final animalReducer = combineReducers<AnimalState>([
  TypedReducer<AnimalState, FetchAnimalListStart>(_onFetch),
  TypedReducer<AnimalState, FetchAnimalListDone>(_onDone),
  TypedReducer<AnimalState, FetchAnimalListError>(_onError),
]);