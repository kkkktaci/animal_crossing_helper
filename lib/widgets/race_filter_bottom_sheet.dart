import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/race_filter/filter_actions.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class RaceFilterBottomSheetPresentation extends StatelessWidget {
  String selectedRace;
  List<String> race;
  RaceFilterBottomSheetPresentation({this.race, this.selectedRace});

  List<Widget> _buildRaceChip(BuildContext context) {
    if (race == null) return [];
    return race.map((item) {
      return ChoiceChip(
        label: Text(item),
        selected: item == selectedRace,
        onSelected: (selected) {
          Navigator.of(context).pop();
          if (!selected) {
            StoreProvider.of<AppState>(context).dispatch(UpdateRaceFilter(race: null));
          } else {
            StoreProvider.of<AppState>(context).dispatch(UpdateRaceFilter(race: item));
          }
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('种族'),
          Wrap(
            spacing: 10,
            children: _buildRaceChip(context),
          )
        ],
      ),
    );
  }
}

class RaceFilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: StoreConnector<AppState, RaceFilterViewModel>(
        distinct: true,
        converter: RaceFilterViewModel.fromStore,
        builder: (context, vm) {
          return RaceFilterBottomSheetPresentation(
            selectedRace: vm.selected,
            race: getAllRace(context),
          );
        },
      ),
    );
  }
}

class RaceFilterViewModel {
  String selected;
  RaceFilterViewModel({this.selected});

  static RaceFilterViewModel fromStore(Store<AppState> store) =>
    RaceFilterViewModel(selected: store.state.raceFilter.selected);

  @override
  int get hashCode => selected.hashCode;

  @override
  operator ==(Object other) =>
  identical(this, other) ||
  other is RaceFilterViewModel &&
    runtimeType == runtimeType &&
    selected == other.selected;
}