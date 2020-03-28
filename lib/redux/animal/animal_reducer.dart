import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:animal_crossing_helper/redux/animal/animal_state.dart';
import 'package:redux/redux.dart';

AnimalState _onFetch(AnimalState state, FetchAnimalListStart action) =>
  AnimalState.fetching();

AnimalState _onDone(AnimalState state, FetchAnimalListDone action) =>
  state.copyWith(animal: action.data, fetching: false, error: null);

AnimalState _onError(AnimalState state, FetchAnimalListError action) =>
  AnimalState.error(action.error);

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

final animalReducer = combineReducers<AnimalState>([
  TypedReducer<AnimalState, FetchAnimalListStart>(_onFetch),
  TypedReducer<AnimalState, FetchAnimalListDone>(_onDone),
  TypedReducer<AnimalState, FetchAnimalListError>(_onError),
  TypedReducer<AnimalState, FetchAnimalDetailDone>(_onDetailDone),
  TypedReducer<AnimalState, FetchAnimalDetailError>(_onDetailError),
]);