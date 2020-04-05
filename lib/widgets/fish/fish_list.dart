import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/fish/fish_actions.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/widgets/catchable_grid.dart';

class FishList extends StatelessWidget {

  CatchableViewModel _fromStore(Store<AppState> store) {
    var fishState = store.state.fish;
    return CatchableViewModel(
      fetching: fishState.fetching,
      data: fishState.fish,
      error: fishState.error,
      filter: store.state.filters
    );
  }

  void _gotoDetail(BuildContext context, NameThing catchable) {
    Navigator.of(context).pushNamed('/catchable_detail', arguments: catchable);
  }

  @override
  Widget build(BuildContext context) {
    print('>>>> build fish list');
    return Container(
      child: CatchableGrid(
        fetchData: fetchFish,
        converter: _fromStore,
        onItemTap: _gotoDetail
      )
    );
  }
}
