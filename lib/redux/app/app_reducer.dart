import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/fish/fish_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    fish: fishReducer(state.fish, action)
  );
}