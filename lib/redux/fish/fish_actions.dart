import 'package:animal_crossing_helper/client/ac_helper_api.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';


class FetchFishStart {}

class FetchFishDone {
  final List<Catchable> data;
  FetchFishDone({this.data});
}

class FetchFishError {
  final Object error;
  FetchFishError({this.error});
}

ThunkAction<AppState> fetchFish(Function(List<NameThing>) onDoneCallback) {
  return (Store<AppState> store) async {
    store.dispatch(FetchFishStart());

    try {
      var result = await Api().getFishList();
      store.dispatch(FetchFishDone(data: result));
      if (onDoneCallback != null) {
        onDoneCallback(result);
      }
    } catch (e) {
      store.dispatch(FetchFishError(error: e.toString()));
    }
  };
}
