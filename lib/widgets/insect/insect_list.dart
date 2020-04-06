import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/redux/insect/insect_actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/widgets/catchable_grid.dart';

class InsectList extends StatelessWidget {

  CatchableViewModel _fromStore(Store<AppState> store) {
    var insectState = store.state.insects;
    return CatchableViewModel(
      fetching: insectState.fetching,
      data: insectState.insects,
      error: insectState.error,
      filter: store.state.catchableFilters
    );
  }

  void _gotoDetail(BuildContext context, NameThing catchable) {
    Navigator.of(context).pushNamed('/catchable_detail', arguments: catchable);
  }

  @override
  Widget build(BuildContext context) {
    print('>>>> build insect list');
    return Container(
      child: CatchableGrid(
        fetchData: fetchInsects,
        converter: _fromStore,
        onItemTap: _gotoDetail
      )
    );
  }
}
