import 'package:animal_crossing_helper/router/catchable_detail.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:animal_crossing_helper/router/home.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';

class App extends StatelessWidget {
  final Store<AppState> store;

  App({this.store});

  final _themeData = ThemeData(
    primaryColor: Colors.green[300],
    // TODO: Add textTheme
    appBarTheme: AppBarTheme(color: Colors.green[300], iconTheme: IconThemeData(color: Colors.white))
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Animal Crossing Helper',
        theme: _themeData,
        home: Home(),
        routes: {
          '/catchable_detail': (context) => CatchableDetail()
        },
      ),
    );
  }
}