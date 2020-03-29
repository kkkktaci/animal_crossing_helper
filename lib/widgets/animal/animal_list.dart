import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/widgets/catchable_grid.dart';

class AnimalList extends StatelessWidget {

  bool _enableSlideOff = true;
  bool _onlyOne = true;
  bool _crossPage = true;
  int _seconds = 10;
  int _animationMilliseconds = 200;
  int _animationReverseMilliseconds = 200;
  BackButtonBehavior _backButtonBehavior = BackButtonBehavior.none;

  NameThingViewModal _fromStore(Store<AppState> store) {
    var animalState = store.state.animal;
    return NameThingViewModal(
      fetching: animalState.fetching,
      data: animalState.animal,
      error: animalState.error
    );
  }

  void _gotoDetail(BuildContext context, NameThing catchable) {
    Navigator.of(context).pushNamed('/animal_detail', arguments: catchable);
  }

  void _showBirthdayNotification(List<NameThing> data) {
    var dateTime = DateTime.now();
    // var today = '${dateTime.month}月${dateTime.day}日';
    var today = '12月1日';
    List<Animal> result = data.where((item) => (item as Animal).birthday.contains(today)).toList();
    if (result.length < 1) return;
    BotToast.showCustomNotification(
      animationDuration: Duration(milliseconds: _animationMilliseconds),
      animationReverseDuration: Duration(milliseconds: _animationReverseMilliseconds),
      duration: Duration(seconds: _seconds),
      backButtonBehavior: _backButtonBehavior,
      enableSlideOff: _enableSlideOff,
      onlyOne: _onlyOne,
      crossPage: _crossPage,
      toastBuilder: (cancel) {
        return _buildNotification(result);
      }
    );
  }

  Widget _buildNotification (List<Animal> animal) {
    InlineSpan leadingSpan = TextSpan(text: '今天是 ');
    InlineSpan tearSpan = TextSpan(text: ' 的生日哦!');
    String names = animal.map((item) => item.name).toList().join(', ');
    List<InlineSpan> content = [
      leadingSpan,
      TextSpan(text: names, style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold)),
      tearSpan
    ];

    return Material(
      elevation: 8,
      borderRadius: BorderRadiusDirectional.all(Radius.circular(16)),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 600,
        height: 100,
        child: Text.rich(TextSpan(
          children: content
        ))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('>>>> build animal list');
    return Container(
      child: CatchableGrid(
        fetchData: fetchAnimalList,
        converter: _fromStore,
        onItemTap: _gotoDetail,
        onFetchDoneCallback: _showBirthdayNotification,
      )
    );
  }
}
