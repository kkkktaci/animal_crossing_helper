import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Glance extends StatelessWidget {
  void _goToDetail(BuildContext context, NameThing catchable) {
    Navigator.of(context).pushNamed('/catchable_detail', arguments: catchable);
  }

  @override
  Widget build(BuildContext context) {
    int month = DateTime.now().month;
    List<Catchable> fish = filterCatchableByMonth(
      context,
      TYPE.FISH,
      month
    );
    List<Catchable> insect = filterCatchableByMonth(
      context,
      TYPE.INSECT,
      month
    );
    return Scaffold(
      appBar: AppBar(title: Text('当月一览', style: TextStyle(color: Colors.white)),),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
            Container(
              // color: Colors.green[100],
              child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: <Widget>[
                  Tab(text: '鱼儿',),
                  Tab(text: '昆虫',),
                ]
              ),
            ),
            _buildTabView(fish, insect)
          ],
        )
      ),
    );
  }

  Expanded _buildTabView(List<NameThing> fish, List<NameThing> insect) {
    return Expanded(
      child: TabBarView(
        children: <Widget>[
          _buildTabContent(fish, _goToDetail),
          _buildTabContent(insect, _goToDetail)
        ]
      )
    );
  }

  Widget _buildTabContent(List<Catchable> data, Function onItemTap) {
    // FIXME: DRY with catchable_grid
    return (GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.0),
      itemBuilder: (context, index) {
        return GridCard(
          onTap: onItemTap,
          nameThing: data[index],
          buildMark: null,
        );
      },
      itemCount: data.length,
    ));
  }
}