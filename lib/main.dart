import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/store.dart';
import 'package:flutter/material.dart';

import 'package:animal_crossing_helper/app.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

void main() async {
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(key: 'state'),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true
  );

  WidgetsFlutterBinding.ensureInitialized();
  final persistState = await persistor.load();
  final store = createStore(persistor, persistState);
  runApp(App(
    store: store
  ));
}
