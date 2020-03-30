import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:animal_crossing_helper/redux/animal/animal_state.dart';
import 'package:redux/redux.dart';

// animal list

AnimalState _onFetch(AnimalState state, FetchAnimalListStart action) =>
  state.copyWith(animal: state.animal, fetching: true, error: null, detailError: null);

AnimalState _onDone(AnimalState state, FetchAnimalListDone action) =>
  state.copyWith(animal: action.data, fetching: false, error: null, detailError: null);

AnimalState _onError(AnimalState state, FetchAnimalListError action) =>
  state.copyWith(animal: state.animal, fetching: false, error: action.error, detailError: state.detailError);

// animal detail

AnimalState _onDetailDone(AnimalState state, FetchAnimalDetailDone action) {
  int index = state.animal.indexWhere((i) => i.name == action.name);
  Animal newAnimal = state.animal[index].clone();
  newAnimal.goal = action.animal.goal;
  newAnimal.motto = action.animal.motto;
  newAnimal.foreignWord = action.animal.foreignWord;
  state.animal.removeAt(index);
  state.animal.insert(index, newAnimal);
  return state;
}
AnimalState _onDetailError(AnimalState state, FetchAnimalDetailError action) {
  return AnimalState(fetching: state.fetching, animal: state.animal, error: state.error, detailError: action.error);
}

// toggle animal mark flag
AnimalState _toggleMark(AnimalState state, ToggleAnimalMark action) {
  int index = state.animal.indexWhere((item) => item.name == action.name);
  var animal = state.animal[index].clone();
  animal.isMarked = !animal.isMarked;
  state.animal.removeAt(index);
  state.animal.insert(index, animal);
  return state;
}

final animalReducer = combineReducers<AnimalState>([
  TypedReducer<AnimalState, FetchAnimalListStart>(_onFetch),
  TypedReducer<AnimalState, FetchAnimalListDone>(_onDone),
  TypedReducer<AnimalState, FetchAnimalListError>(_onError),
  TypedReducer<AnimalState, FetchAnimalDetailDone>(_onDetailDone),
  TypedReducer<AnimalState, FetchAnimalDetailError>(_onDetailError),
  TypedReducer<AnimalState, ToggleAnimalMark>(_toggleMark),
]);