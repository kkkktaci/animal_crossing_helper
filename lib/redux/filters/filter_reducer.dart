import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/filters/filter_actions.dart';
import 'package:animal_crossing_helper/redux/filters/filter_state.dart';

FilterState _onChangePrice(FilterState state, ChangePriceSort action) {
  return FilterState(priceSort: action.price);
}

final filterReducer = combineReducers<FilterState>([
  TypedReducer<FilterState, ChangePriceSort>(_onChangePrice),
]);