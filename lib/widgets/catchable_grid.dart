import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CatchableGrid extends StatefulWidget {
  Function(BuildContext, Catchable) onItemTap;
  Function fetchData;
  Function(Store<AppState>) converter;

  CatchableGrid({this.onItemTap, this.fetchData, this.converter});

  @override
  _CatchableGridState createState() => _CatchableGridState();
}

class _CatchableGridState extends State<CatchableGrid> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StoreConnector<AppState, CatchableViewModal>(
        distinct: true,
        converter: widget.converter,
        onInit: (store) => store.dispatch(widget.fetchData()),
        builder: (context, vm) {
          if (vm.fetching) {
            return Text('loading');
          }

          return (GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0
            ),
            itemBuilder: (context, index) {
              return GridCard(onTap: widget.onItemTap, catchable: vm.data[index]);
            },
            itemCount: vm.data.length,
          ));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CatchableViewModal {
  bool fetching;
  List<Catchable> data;
  Object error;

  CatchableViewModal({this.fetching, this.data, this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatchableViewModal &&
          runtimeType == other.runtimeType &&
          fetching == other.fetching &&
          data == other.data &&
          error == other.error;

  @override
  int get hashCode => fetching.hashCode ^ data.hashCode ^ error.hashCode;
}