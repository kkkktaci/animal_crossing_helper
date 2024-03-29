import 'package:animal_crossing_helper/client/ac_helper_api.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';


class FetchInsectsStart {}

class FetchInsectsDone {
  final List<Catchable> data;
  FetchInsectsDone({this.data});
}

class FetchInsectsError {
  final Object error;
  FetchInsectsError({this.error});
}

ThunkAction<AppState> fetchInsects() {
  return (Store<AppState> store) async {
    if (store.state.insects.fetching) return;
    store.dispatch(FetchInsectsStart());

    try {
      var result = await Api().getInsectList();
      store.dispatch(FetchInsectsDone(data: result));
    } catch (e) {
      store.dispatch(FetchInsectsError(error: e.toString()));
    }
  };
}
