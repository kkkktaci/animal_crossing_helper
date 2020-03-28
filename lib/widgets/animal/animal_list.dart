import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/widgets/catchable_grid.dart';

class AnimalList extends StatelessWidget {

  NameThingViewModal _fromStore(Store<AppState> store) {
    var animalState = store.state.animal;
    return NameThingViewModal(
      fetching: animalState.fetching,
      data: animalState.animal,
      error: animalState.error
    );
  }

  void _gotoDetail(BuildContext context, NameThing catchable) {
    // Navigator.of(context).pushNamed('/catchable_detail', arguments: catchable);
  }

  @override
  Widget build(BuildContext context) {
    print('>>>> build animal list');
    return Container(
      child: CatchableGrid(
        fetchData: fetchAnimalList,
        converter: _fromStore,
        onItemTap: _gotoDetail
      )
    );
  }
}
