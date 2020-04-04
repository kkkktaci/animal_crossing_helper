import 'package:animal_crossing_helper/router/glance.dart';
import 'package:animal_crossing_helper/router/my_follow.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:animal_crossing_helper/router/animal_detail.dart';
import 'package:animal_crossing_helper/router/catchable_detail.dart';
import 'package:animal_crossing_helper/router/home.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';

class App extends StatelessWidget {
  final Store<AppState> store;

  App({this.store});

  final _themeData = ThemeData(
    primaryColor: Colors.green[300],
    // TODO: Add textTheme in app bar theme
    appBarTheme: AppBarTheme(color: Colors.green[300], iconTheme: IconThemeData(color: Colors.white)),
    textTheme: TextTheme(
      display1: TextStyle(fontSize: 18, color: Colors.black),
      display2: TextStyle(fontSize: 16, color: Colors.black),
      display3: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      body1: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
      body2: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w300),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: BotToastInit(
        child: MaterialApp(
          title: 'Animal Crossing Helper',
          theme: _themeData,
          navigatorObservers: [BotToastNavigatorObserver()],
          home: Home(),
          routes: {
            '/catchable_detail': (context) => CatchableDetail(),
            '/animal_detail': (context) => AnimalDetail(),
            '/glance': (context) => Glance(),
            '/my_follow': (context) => MyFollow(),
          },
        ),
      ),
    );
  }
}