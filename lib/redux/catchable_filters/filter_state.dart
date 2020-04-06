import 'package:animal_crossing_helper/redux/price_sort.dart';

class CatchableFilterState {
  PRICE priceSort;
  List<String> fishPlaces;
  List<String> insectPlaces;

  CatchableFilterState({this.priceSort, this.fishPlaces, this.insectPlaces});

  factory CatchableFilterState.initial() =>
    CatchableFilterState(priceSort: PRICE.NONE, fishPlaces: [], insectPlaces: []);

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is CatchableFilterState &&
      runtimeType == other.runtimeType &&
      priceSort == other.priceSort &&
      fishPlaces == other.fishPlaces &&
      insectPlaces == other.insectPlaces;
  
  @override
  int get hashCode =>
    priceSort.hashCode ^ fishPlaces.hashCode ^ insectPlaces.hashCode;

  @override
  String toString() {
    return 'CatchableFilterState{price: $priceSort, fish: $fishPlaces, insect: $insectPlaces}';
  }
}