import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/app/app_reducer.dart';

Store<AppState> createStore(Persistor<AppState> persistor, AppState persistState) {
  return Store<AppState>(
    appReducer,
    initialState: persistState ?? AppState.initial(),
    middleware: [
      thunkMiddleware,
      LoggingMiddleware.printer(),
      persistor.createMiddleware()
    ]
  );
}