import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/fish/fish_actions.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/widgets/catchable_grid.dart';

class FishList extends StatefulWidget {
  @override
  _FishListState createState() => _FishListState();
}

class _FishListState extends State<FishList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  CatchableViewModal _fromStore(Store<AppState> store) {
    var fishState = store.state.fish;
    return CatchableViewModal(
      fetching: fishState.fetching,
      data: fishState.fish,
      error: fishState.error
    );
  }

  void _gotoDetail(BuildContext context, Catchable catchable) {
    Navigator.of(context).pushNamed('/catchable_detail', arguments: catchable);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CatchableGrid(
        fetchData: fetchFish,
        converter: _fromStore,
        onItemTap: _gotoDetail
      )
    );
  }
}
