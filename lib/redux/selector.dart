import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

List<Catchable> filterCatchableByMonth(BuildContext context, TYPE type, int month) {
  AppState state = StoreProvider.of<AppState>(context).state;
  final monthString = '$month';
  List<Catchable> data;
  if (type == TYPE.FISH) data = state.fish.fish;
  else data = state.insects.insects;
  return data.where((f) {
    return f.north.contains(monthString);
  }).toList();
}

List<Animal> getAllMyFollowAnimal(BuildContext context) {
  AppState state = StoreProvider.of<AppState>(context).state;
  return state.animal.animal.where((a) => a.isMarked).toList();
}

bool isNorth(BuildContext context) {
  return StoreProvider.of<AppState>(context).state.location.north;
}