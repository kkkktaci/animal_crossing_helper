import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/price_sort.dart';

class ChangePriceSort {
  PRICE price;
  ChangePriceSort({this.price});
}

class UpdatePlaceFilter {
  String palce;
  bool selected;
  TYPE type;
  UpdatePlaceFilter({this.palce, this.selected, this.type});
}