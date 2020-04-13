import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/catchable_filters/filter_actions.dart';
import 'package:animal_crossing_helper/redux/catchable_filters/filter_state.dart';
import 'package:animal_crossing_helper/redux/price_sort.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

/// 价格排序和捕获地点过滤
class FilterBottomSheet extends StatefulWidget {
  TYPE type;
  List<String> allPlace;
  FilterBottomSheet({this.type, this.allPlace});
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Widget _buildSortByPrice(PRICE priceSort) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('价格排序'),
        Wrap(
          spacing: 10,
          children: <Widget>[
            ChoiceChip(
              label: Text('价格升序'),
              selected: priceSort == PRICE.UPWARD,
              onSelected: (selected) {
                Navigator.pop(context);
                StoreProvider.of<AppState>(context).dispatch(ChangePriceSort(
                    price: selected ? PRICE.UPWARD : PRICE.NONE));
              },
            ),
            ChoiceChip(
              label: Text('价格降序'),
              selected: priceSort == PRICE.FAIL,
              onSelected: (selected) {
                Navigator.pop(context);
                StoreProvider.of<AppState>(context).dispatch(
                    ChangePriceSort(price: selected ? PRICE.FAIL : PRICE.NONE));
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSortByPlace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('捕获地点'),
        Wrap(
          spacing: 10,
          children: _buildPlaceFilter(),
        )
      ],
    );
  }

  List<FilterChip> _buildPlaceFilter() {
    if (widget.allPlace == null) return List<FilterChip>();
    List<String> selectedPlace;
    if (widget.type == TYPE.FISH) {
      selectedPlace = getFishSelectedFilters(context);
    } else {
      selectedPlace = getInsectSelectedFilters(context);
    }
    return widget.allPlace.map((item) {
      bool selected = selectedPlace.contains(item);
      return FilterChip(
        label: Text(item),
        selected: selected,
        onSelected: (selected) {
          StoreProvider.of<AppState>(context).dispatch(
              UpdatePlaceFilter(palce: item, selected: selected, type: widget.type));
          setState(() {});
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FilterViewModel>(
      distinct: true,
      converter: FilterViewModel.fromStore,
      builder: (context, vm) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSortByPrice(vm.filter.priceSort),
                  Divider(),
                  _buildSortByPlace()
                ],
              )),
        );
      },
    );
  }
}

class FilterViewModel {
  CatchableFilterState filter;
  FilterViewModel({this.filter});
  static FilterViewModel fromStore(Store<AppState> store) =>
      FilterViewModel(filter: store.state.catchableFilters);

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is FilterViewModel &&
          runtimeType == other.runtimeType &&
          filter == other.filter;

  @override
  int get hashCode => filter.hashCode;
}
