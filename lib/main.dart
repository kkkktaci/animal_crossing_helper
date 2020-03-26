import 'package:animal_crossing_helper/redux/store.dart';
import 'package:flutter/material.dart';

import 'package:animal_crossing_helper/app.dart';

void main() {
  final store = createStore();
  runApp(App(
    store: store
  ));
}
