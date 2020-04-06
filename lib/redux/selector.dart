import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/price_sort.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

List<Catchable> filterCatchableByMonth(BuildContext context, TYPE type, int month) {
  AppState state = StoreProvider.of<AppState>(context).state;
  final monthString = '$month';
  bool _north = state.location.north;
  List<Catchable> data;
  if (type == TYPE.FISH) data = state.fish.fish;
  else data = state.insects.insects;
  return data.where((f) {
    if (_north) {
      return f.north.contains(monthString);
    }
    return f.south.contains(monthString);
  }).toList();
}

List<Catchable> getCatchableAfterFilter(BuildContext context, List<Catchable> data) {
  AppState state = StoreProvider.of<AppState>(context).state;
  if (state.catchableFilters.priceSort == PRICE.NONE) {
    return data;
  }
  List<Catchable> _data = List<Catchable>.from(data);
  _data.sort((a, b) {
    if (state.catchableFilters.priceSort == PRICE.UPWARD) {
      return int.parse(a.price).compareTo(int.parse(b.price));
    } else if (state.catchableFilters.priceSort == PRICE.FAIL) {
      return int.parse(b.price).compareTo(int.parse(a.price));
    }
  });
  return _data;
}

List<Animal> getAllMyFollowAnimal(BuildContext context) {
  AppState state = StoreProvider.of<AppState>(context).state;
  return state.animal.animal.where((a) => a.isMarked).toList();
}

bool isNorth(BuildContext context) {
  return StoreProvider.of<AppState>(context).state.location.north;
}