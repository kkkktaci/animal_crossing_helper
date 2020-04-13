import 'package:animal_crossing_helper/delegate/search_name_thing_delegate.dart';
import 'package:animal_crossing_helper/delegate/sliver_search_bar_delegate.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/price_sort.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
import 'package:animal_crossing_helper/widgets/filter_bottom_sheet.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
import 'package:animal_crossing_helper/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CatchableGridPresentation extends StatelessWidget {
  final CatchableViewModel vm;
  final Function(BuildContext, NameThing) onItemTap;
  final TYPE type;
  CatchableGridPresentation({Key key, this.vm, this.onItemTap, this.type}) : super(key: key);

  List<Catchable> _sortedData;
  List<String> _allPlace;

  void _onSearchTap(BuildContext context) async {
    List<Catchable> catchable;
    if (type == TYPE.FISH) catchable = getOriginFish(context);
    else catchable = getOriginInsect(context);
    if (catchable != null && catchable.length <= 0) return;
    await showSearch(
      context: context,
      delegate: SearchNameThingDelegate(catchable, onItemTap)
    );
  }

  // FIXME: put this in selector
  List<String> _getAllPlace(List<Catchable> data) {
    if (data == null) return [];
    if (this._allPlace != null && this._allPlace.length > 0) return this._allPlace;
    var placeSet = Set<String>();
    placeSet.addAll(data.map((item) => item.activePlace));
    return placeSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    if (vm.fetching && vm.data.length == 0) {
      return Loading();
    }

    this._sortedData = getCatchableAfterFilter(context, vm.data, type);
    this._allPlace = _getAllPlace(vm.data);
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          floating: true,
          delegate: SliverSearchBarDelegate(
            onTap: this._onSearchTap,
            bottomSheet: FilterBottomSheet(type: type, allPlace: _allPlace,)
          )
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.0),
          delegate: SliverChildBuilderDelegate((context, index) {
            return GridCard(
              onTap: onItemTap,
              nameThing: _sortedData[index],
            );
          },
          childCount: _sortedData.length)
        )
      ],
    );
  }
}

class CatchableGrid extends StatelessWidget {
  Function(BuildContext, NameThing) onItemTap;
  Function fetchData;
  TYPE type;

  CatchableGrid({this.onItemTap, this.fetchData, this.type});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CatchableViewModel>(
      // distinct: true,
      converter: (store) => CatchableViewModel.fromStore(store, type),
      onInit: (store) => store.dispatch(fetchData()),
      builder: (context, vm) {
        return CatchableGridPresentation(
          vm: vm,
          onItemTap: onItemTap,
          type: type,
        );
      },
    );
  }
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
