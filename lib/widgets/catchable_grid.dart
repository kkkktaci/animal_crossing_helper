import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/price_sort.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
import 'package:animal_crossing_helper/widgets/filter_bottom_sheet.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
import 'package:animal_crossing_helper/widgets/search_name_thing_delegate.dart';
import 'package:animal_crossing_helper/widgets/sliver_search_bar_delegate.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CatchableGrid extends StatefulWidget {
  Function(BuildContext, NameThing) onItemTap;
  Function fetchData;
  TYPE type;

  CatchableGrid({this.onItemTap, this.fetchData, this.type});

  @override
  _CatchableGridState createState() => _CatchableGridState();
}

class _CatchableGridState extends State<CatchableGrid>
    with AutomaticKeepAliveClientMixin {

  List<Catchable> _originData;
  List<Catchable> _sortedData;
  List<String> _allPlace;

  void _onSearchTap() async {
    if (_originData.length <= 0) return;
    await showSearch(
      context: context,
      delegate: SearchNameThingDelegate(_originData, widget.onItemTap)
    );
  }

  List<String> _getAllPlace(List<Catchable> data) {
    if (data == null) return [];
    if (this._allPlace != null && this._allPlace.length > 0) return this._allPlace;
    var placeSet = Set<String>();
    placeSet.addAll(data.map((item) => item.activePlace));
    return placeSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, CatchableViewModel>(
      // distinct: true,
      converter: (store) => CatchableViewModel.fromStore(store, widget.type),
      onInit: (store) => store.dispatch(widget.fetchData()),
      builder: (context, vm) {
        if (vm.fetching && vm.data.length == 0) {
          return Container(
            width: 50,
            height: 50,
            child: FlareActor('assets/loading.flr', animation: 'Alarm',),
          );
        }

        if (_originData == null) _originData = vm.data;
        this._sortedData = getCatchableAfterFilter(context, vm.data, widget.type);
        this._allPlace = _getAllPlace(vm.data);
        return CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              delegate: SliverSearchBarDelegate(
                onTap: this._onSearchTap,
                bottomSheet: FilterBottomSheet(type: widget.type, allPlace: _allPlace,)
              )
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.0),
              delegate: SliverChildBuilderDelegate((context, index) {
                return GridCard(
                  onTap: widget.onItemTap,
                  nameThing: _sortedData[index],
                );
              },
              childCount: _sortedData.length)
            )
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CatchableViewModel {
  bool fetching;
  List<Catchable> data;
  Object error;
  PRICE priceSort;
  List<String> selectedFilter;

  CatchableViewModel({this.fetching, this.data, this.error, this.priceSort, this.selectedFilter});

  static CatchableViewModel fromStore(Store<AppState> store, TYPE type) {
    if (TYPE.FISH == type) {
      return CatchableViewModel(
        fetching: store.state.fish.fetching,
        data: store.state.fish.fish,
        error: store.state.fish.error,
        priceSort: store.state.catchableFilters.priceSort,
        selectedFilter: store.state.catchableFilters.fishPlaces
      );
    } else {
      return CatchableViewModel(
        fetching: store.state.insects.fetching,
        data: store.state.insects.insects,
        error: store.state.insects.error,
        priceSort: store.state.catchableFilters.priceSort,
        selectedFilter: store.state.catchableFilters.insectPlaces
      );
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatchableViewModel &&
          runtimeType == other.runtimeType &&
          fetching == other.fetching &&
          data == other.data &&
          error == other.error &&
          priceSort == other.priceSort &&
          selectedFilter == other.selectedFilter;

  @override
  int get hashCode => fetching.hashCode ^ data.hashCode ^ error.hashCode ^ priceSort.hashCode ^ selectedFilter.hashCode;
}
