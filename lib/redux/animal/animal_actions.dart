import 'package:animal_crossing_helper/client/ac_helper_api.dart';
import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';


class FetchAnimalListStart {}

class FetchAnimalListDone {
  final List<Animal> data;
  FetchAnimalListDone({this.data});
}

class FetchAnimalListError {
  final Object error;
  FetchAnimalListError({this.error});
}

ThunkAction<AppState> fetchAnimalList() {
  return (Store<AppState> store) async {
    store.dispatch(FetchAnimalListStart());

    try {
      store.dispatch(FetchAnimalListDone(data: await Api().getAnimalList()));
    } catch (e) {
      store.dispatch(FetchAnimalListError(error: e.toString()));
    }
  };
}

class FetchAnimalDetailStart {}

class FetchAnimalDetailDone {
  String name;
  Animal animal;
  FetchAnimalDetailDone({this.name, this.animal});
}

class FetchAnimalDetailError {
  Object error;
  FetchAnimalDetailError({this.error});
}

ThunkAction<AppState> fetchAnimalDetailIfNeeded(String name) {
  return (Store<AppState> store) {
    if(store.state.animal.animal.singleWhere((item) => item.name == name).goal != null) return;
    store.dispatch(fetchAnimalDetail(name));
  };
}

ThunkAction<AppState> fetchAnimalDetail(String name) {
  return (Store<AppState> store) async {
    store.dispatch(FetchAnimalDetailStart());

    try {
      store.dispatch(FetchAnimalDetailDone(name: name, animal: await Api().getAnimalDetail(name)));
    } catch (e) {
      store.dispatch(FetchAnimalDetailError(error: e.toString()));
    }
  };
}
