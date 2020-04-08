import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

bool ENABLE_SLIDE_OFF = true;
bool ONLY_ONCE = true;
bool CROSS_PAGE = true;
int SECOND = 10;
int ANIMATION_MILLISECONDS = 200;
int ANIMATION_REVERSE_MILLISECONDS = 200;
BackButtonBehavior BACK_BUTTON_BEHAVIOR = BackButtonBehavior.none;

void showBirthdayNotification(List<NameThing> data) {
  var dateTime = DateTime.now();
  var today = '${dateTime.month}月${dateTime.day}日';
  List<Animal> result = data.where((item) => (item as Animal).birthday.contains(today)).toList();
  if (result.length < 1) return;
  BotToast.showCustomNotification(
    animationDuration: Duration(milliseconds: ANIMATION_MILLISECONDS),
    animationReverseDuration: Duration(milliseconds: ANIMATION_REVERSE_MILLISECONDS),
    duration: Duration(seconds: SECOND),
    backButtonBehavior: BACK_BUTTON_BEHAVIOR,
    enableSlideOff: ENABLE_SLIDE_OFF,
    onlyOne: ONLY_ONCE,
    crossPage: CROSS_PAGE,
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

  // 查找今天的生日中是否有关注的小动物
  String islanderString;
  List<Animal> markAnimal = animal.where((item) => item.isMarked).toList();
  if (markAnimal.length > 0) {
    islanderString = markAnimal.map((item) => item.name).toList().join(',');
    content.addAll([
      TextSpan(text: '\n'),
      TextSpan(text: '其中 '),
      TextSpan(text: islanderString, style: TextStyle(color: Colors.red[200], fontWeight: FontWeight.bold)),
      TextSpan(text: ' 是你关注的哦!')
    ]);
  }

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