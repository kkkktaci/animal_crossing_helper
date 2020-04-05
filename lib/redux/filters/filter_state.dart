import 'package:animal_crossing_helper/redux/price_sort.dart';

class FilterState {
  PRICE priceSort;

  FilterState({this.priceSort});

  factory FilterState.initial() =>
    FilterState(priceSort: PRICE.NONE);

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is FilterState &&
      runtimeType == other.runtimeType &&
      priceSort == other.priceSort;
  
  @override
  int get hashCode =>
    priceSort.hashCode;

  @override
  String toString() {
    return 'FilterState{price: $priceSort}';
  }
}