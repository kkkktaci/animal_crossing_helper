import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/insect/insect_actions.dart';
import 'package:flutter/material.dart';
import 'package:animal_crossing_helper/widgets/catchable_grid.dart';


class InsectList extends StatefulWidget {
  @override
  _InsectListState createState() => _InsectListState();
}

class _InsectListState extends State<InsectList> with AutomaticKeepAliveClientMixin {
  void _gotoDetail(BuildContext context, NameThing catchable) {
    Navigator.of(context).pushNamed('/catchable_detail', arguments: catchable);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('>>>> build insect list');
    return Container(
      child: CatchableGrid(
        type: TYPE.INSECT,
        fetchData: fetchInsects,
        onItemTap: _gotoDetail
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
