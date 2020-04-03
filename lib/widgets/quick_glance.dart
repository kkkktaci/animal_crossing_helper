import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class QuickGlance extends StatelessWidget {
  int month;
  QuickGlance() {
    month = DateTime.now().month;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            _buildBlock(context, TYPE.FISH),
            _buildBlock(context, TYPE.INSECT),
          ],
        ),
      ),
    );
  }

  Widget _buildBlock(BuildContext context, TYPE type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text('$month 月${type == TYPE.FISH ? '鱼儿' : '昆虫'}一览', style: Theme.of(context).textTheme.body1)
        ),
        Text(_getFishContent(context, type), style: Theme.of(context).textTheme.body2,),
      ],
    );
  }

  String _getFishContent(BuildContext context, TYPE type) {
    var data = filterCatchableByMonth(StoreProvider.of<AppState>(context).state, type, month);
    if (data.length > 0) {
      return data.map((f) => f.name).join(', ');
    }
    return "需要获取数据";
  }
}