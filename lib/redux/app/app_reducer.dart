import 'package:animal_crossing_helper/redux/animal/animal_reducer.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/filters/filter_reducer.dart';
import 'package:animal_crossing_helper/redux/fish/fish_reducer.dart';
import 'package:animal_crossing_helper/redux/insect/insect_reducer.dart';
import 'package:animal_crossing_helper/redux/location/location_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    fish: fishReducer(state.fish, action),
    insects: insectReducer(state.insects, action),
    animal: animalReducer(state.animal, action),
    location: locationReducer(state.location, action),
    filters: filterReducer(state.filters, action)
  );
}