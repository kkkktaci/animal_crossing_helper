import 'package:animal_crossing_helper/client/ac_helper_api.dart';
import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

// fetch animal list

class FetchAnimalListStart {}

class FetchAnimalListDone {
  final List<Animal> data;
  FetchAnimalListDone({this.data});
}

class FetchAnimalListError {
  final Object error;
  FetchAnimalListError({this.error});
}

ThunkAction<AppState> fetchAnimalList(Function(List<NameThing>) onDoneCallback) {
  return (Store<AppState> store) async {
    if (store.state.animal.fetching) return;
    store.dispatch(FetchAnimalListStart());

    try {
      var result = await Api().getAnimalList();
      store.dispatch(FetchAnimalListDone(data: result));
      if (onDoneCallback != null) {
        onDoneCallback(result);
      }
    } catch (e) {
      store.dispatch(FetchAnimalListError(error: e.toString()));
    }
  };
}

// fetch animal detail

class FetchAnimalDetailStart {
  String name;
  FetchAnimalDetailStart({this.name});
}

class FetchAnimalDetailDone {
  String name;
  Animal animal;
  FetchAnimalDetailDone({this.name, this.animal});
}

class FetchAnimalDetailError {
  String name;
  Object error;
  FetchAnimalDetailError({this.error, this.name});
}

ThunkAction<AppState> fetchAnimalDetailIfNeeded(String name) {
  return (Store<AppState> store) {
    if(store.state.animal.animal.singleWhere((item) => item.name == name).goal != null) return;
    store.dispatch(fetchAnimalDetail(name));
  };
}

ThunkAction<AppState> fetchAnimalDetail(String name) {
  return (Store<AppState> store) async {
    store.dispatch(FetchAnimalDetailStart(name: name));

    try {
      store.dispatch(FetchAnimalDetailDone(name: name, animal: await Api().getAnimalDetail(name)));
    } catch (e) {
      store.dispatch(FetchAnimalDetailError(name: name, error: e.toString()));
    }
  };
}

// update animal mark flag
class ToggleAnimalMark {
  String name;
  ToggleAnimalMark({this.name});
}