import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/catchable_filters/filter_actions.dart';
import 'package:animal_crossing_helper/redux/catchable_filters/filter_state.dart';
import 'package:animal_crossing_helper/redux/price_sort.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
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
  Function(Store<AppState>) converter;
  Function(List<NameThing> data) onFetchDoneCallback;
  Function(NameThing) buildMark;

  CatchableGrid({this.onItemTap, this.fetchData, this.converter, this.onFetchDoneCallback, this.buildMark});

  @override
  _CatchableGridState createState() => _CatchableGridState();
}

class _CatchableGridState extends State<CatchableGrid>
    with AutomaticKeepAliveClientMixin {

  List<Catchable> _data;

  void _onSearchTap(BuildContext context) async {
    if (_data.length <= 0) return;
    await showSearch(
      context: context,
      delegate: SearchNameThingDelegate(_data, widget.onItemTap)
    );
  }

  Widget _buildBottomSheet(BuildContext context, CatchableFilterState filter) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      // color: Colors.red,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSortByPrice(context, filter),
            Divider(),

          ],
        )
      ),
    );
  }

  Widget _buildSortByPrice(BuildContext context, CatchableFilterState filter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('价格排序'),
        Wrap(
          spacing: 10,
          children: <Widget>[
            ChoiceChip(
              label: Text('价格升序'),
              selected: filter.priceSort == PRICE.UPWARD,
              onSelected: (selected) {
                Navigator.pop(context);
                StoreProvider.of<AppState>(context).dispatch(ChangePriceSort(price: selected ? PRICE.UPWARD : PRICE.NONE));
              },
            ),
            ChoiceChip(
              label: Text('价格降序'),
              selected: filter.priceSort == PRICE.FAIL,
              onSelected: (selected) {
                Navigator.pop(context);
                StoreProvider.of<AppState>(context).dispatch(ChangePriceSort(price: selected ? PRICE.FAIL : PRICE.NONE));
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSortByPlace(BuildContext context) {
    
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, CatchableViewModel>(
      distinct: true,
      converter: widget.converter,
      onInit: (store) => store.dispatch(widget.fetchData(widget.onFetchDoneCallback)),
      builder: (context, vm) {
        if (vm.fetching && vm.data.length == 0) {
          return Container(
            width: 50,
            height: 50,
            child: FlareActor('assets/loading.flr', animation: 'Alarm',),
          );
        }

        this._data = getCatchableAfterFilter(context, vm.data);
        return CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              delegate: SliverSearchBarDelegate(onTap: this._onSearchTap, bottomSheet: _buildBottomSheet(context, vm.filter))
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.0),
              delegate: SliverChildBuilderDelegate((context, index) {
                return GridCard(
                  onTap: widget.onItemTap,
                  nameThing: _data[index],
                  buildMark: widget.buildMark,
                );
              },
              childCount: _data.length)
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
  CatchableFilterState filter;

  CatchableViewModel({this.fetching, this.data, this.error, this.filter});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatchableViewModel &&
          runtimeType == other.runtimeType &&
          fetching == other.fetching &&
          data == other.data &&
          error == other.error &&
          filter == other.filter;

  @override
  int get hashCode => fetching.hashCode ^ data.hashCode ^ error.hashCode ^ filter.hashCode;
}
