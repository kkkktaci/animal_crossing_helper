import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:flutter/material.dart';
import 'package:animal_crossing_helper/redux/fish/fish_actions.dart';
import 'package:animal_crossing_helper/widgets/catchable_grid.dart';

class FishList extends StatefulWidget {
  @override
  _FishListState createState() => _FishListState();
}

class _FishListState extends State<FishList> with AutomaticKeepAliveClientMixin {
  void _gotoDetail(BuildContext context, NameThing catchable) {
    Navigator.of(context).pushNamed('/catchable_detail', arguments: catchable);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('>>>> build fish list');
    return Container(
      child: CatchableGrid(
        type: TYPE.FISH,
        fetchData: fetchFish,
        onItemTap: _gotoDetail
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
