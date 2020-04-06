import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/catchable_filters/filter_actions.dart';
import 'package:animal_crossing_helper/redux/catchable_filters/filter_state.dart';
import 'package:redux/redux.dart';

CatchableFilterState _onChangePrice(CatchableFilterState state, ChangePriceSort action) {
  return CatchableFilterState(priceSort: action.price, fishPlaces: state.fishPlaces, insectPlaces: state.insectPlaces);
}

CatchableFilterState _onUpdatePlace(CatchableFilterState state, UpdatePlaceFilter action) {
  CatchableFilterState current = CatchableFilterState(priceSort: state.priceSort, fishPlaces: state.fishPlaces, insectPlaces: state.insectPlaces);
  if (action.selected) {
    if (action.type == TYPE.FISH) {
      current.fishPlaces.add(action.palce);
    } else {
      current.insectPlaces.add(action.palce);
    }
  } else {
    if (action.type == TYPE.FISH) {
      current.fishPlaces.remove(action.palce);
    } else {
      current.insectPlaces.remove(action.palce);
    }
  }
  return current;
}

final catchableFilterReducer = combineReducers<CatchableFilterState>([
  TypedReducer<CatchableFilterState, ChangePriceSort>(_onChangePrice),
  TypedReducer<CatchableFilterState, UpdatePlaceFilter>(_onUpdatePlace),
]);