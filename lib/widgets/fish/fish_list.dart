import 'package:animal_crossing_helper/redux/fish/fish_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/fish/fish_state.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';

class FishList extends StatefulWidget {
  @override
  _FishListState createState() => _FishListState();
}

class _FishListState extends State<FishList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector<AppState, FishListViewModel>(
        distinct: true,
        converter: FishListViewModel.fromStore,
        onInit: (store) => 
          store.dispatch(fetchFish()),
        builder: (context, vm) {
          if (vm.state.fetching) {
            return Text('loading');
          }

          return (GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0
            ),
            itemBuilder: (context, index) {
              return GridCard(catchable: vm.state.fish[index]);
            },
            itemCount: vm.state.fish.length,
          ));
        }
      )
    );
  }
}

class FishListViewModel {
  FishState state;

  FishListViewModel({this.state});

  static FishListViewModel fromStore(Store<AppState> store) =>
    FishListViewModel(state: store.state.fish);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FishListViewModel &&
          runtimeType == other.runtimeType &&
          state == other.state;

  @override
  int get hashCode => state.hashCode;
}