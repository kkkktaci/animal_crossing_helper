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

List<Catchable> getCatchableAfterFilter(BuildContext context, List<Catchable> data, TYPE type) {
  AppState state = StoreProvider.of<AppState>(context).state;
  List<Catchable> _data = List<Catchable>.from(data);
  // apply price sort
  if (state.catchableFilters.priceSort != PRICE.NONE) {
    _data.sort((a, b) {
      if (state.catchableFilters.priceSort == PRICE.UPWARD) {
        return int.parse(a.price).compareTo(int.parse(b.price));
      } else if (state.catchableFilters.priceSort == PRICE.FAIL) {
        return int.parse(b.price).compareTo(int.parse(a.price));
      }
    });
  }

  // apply place filter
  List<String> placeFilter;
  if (type == TYPE.FISH) {
    placeFilter = state.catchableFilters.fishPlaces;
  } else {
    placeFilter = state.catchableFilters.insectPlaces;
  }
  if (placeFilter.length == 0) return _data;
  return _data.where((item) => placeFilter.contains(item.activePlace)).toList();
}

List<String> getFishSelectedFilters(BuildContext context) {
  return StoreProvider.of<AppState>(context).state.catchableFilters.fishPlaces;
}

List<String> getInsectSelectedFilters(BuildContext context) {
  return StoreProvider.of<AppState>(context).state.catchableFilters.insectPlaces;
}

List<String> getAllRace(BuildContext context) {
  List<Animal> allAnimal = StoreProvider.of<AppState>(context).state.animal.animal;
  Set<String> race = Set<String>();
  allAnimal.forEach((animal) {
    if (animal.race.trim().isNotEmpty && !race.contains(animal.race)) race.add(animal.race.trim());
  });
  return race.toList();
}

List<Animal> getAnimalAfterFilter(BuildContext context) {
  AppState state = StoreProvider.of<AppState>(context).state;
  String selectedRace = state.raceFilter.selected;
  if (selectedRace == null) {
    // 当前没有选择任何过滤
    return state.animal.animal;
  }
  return state.animal.animal.where((item) => item.race.trim() == selectedRace).toList();
}

List<Catchable> getOriginFish(BuildContext context) {
  return StoreProvider.of<AppState>(context).state.fish.fish;
}

List<Catchable> getOriginInsect(BuildContext context) {
  return StoreProvider.of<AppState>(context).state.insects.insects;
}

List<Animal> getOriginAnimal(BuildContext context) {
  return StoreProvider.of<AppState>(context).state.animal.animal;
}

List<Animal> getAllMyFollowAnimal(BuildContext context) {
  AppState state = StoreProvider.of<AppState>(context).state;
  return state.animal.animal.where((a) => a.isMarked).toList();
}

bool isNorth(BuildContext context) {
  return StoreProvider.of<AppState>(context).state.location.north;
}