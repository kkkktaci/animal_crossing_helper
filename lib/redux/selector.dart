import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';

List<Catchable> filterCatchableByMonth(AppState state, TYPE type, int month) {
  final monthString = '$month';
  List<Catchable> data;
  if (type == TYPE.FISH) data = state.fish.fish;
  else data = state.insects.insects;
  return data.where((f) {
    return f.north.contains(monthString);
  }).toList();
}

List<Animal> getAllMyFollowAnimal(AppState state) {
  return state.animal.animal.where((a) => a.isMarked).toList();
}