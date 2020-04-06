import 'package:animal_crossing_helper/redux/catchable_filters/filter_actions.dart';
import 'package:animal_crossing_helper/redux/catchable_filters/filter_state.dart';
import 'package:redux/redux.dart';

CatchableFilterState _onChangePrice(CatchableFilterState state, ChangePriceSort action) {
  return CatchableFilterState(priceSort: action.price);
}

final catchableFilterReducer = combineReducers<CatchableFilterState>([
  TypedReducer<CatchableFilterState, ChangePriceSort>(_onChangePrice),
]);