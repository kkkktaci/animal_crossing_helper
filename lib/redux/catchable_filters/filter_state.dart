import 'package:animal_crossing_helper/redux/price_sort.dart';

class CatchableFilterState {
  PRICE priceSort;

  CatchableFilterState({this.priceSort});

  factory CatchableFilterState.initial() =>
    CatchableFilterState(priceSort: PRICE.NONE);

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is CatchableFilterState &&
      runtimeType == other.runtimeType &&
      priceSort == other.priceSort;
  
  @override
  int get hashCode =>
    priceSort.hashCode;

  @override
  String toString() {
    return 'CatchableFilterState{price: $priceSort}';
  }
}