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

class _CatchableGridState extends State<CatchableGrid>
    with AutomaticKeepAliveClientMixin {

  List<Catchable> _data;

  void _onSearchTap(BuildContext context, List<Catchable> data) async {
    if (_data.length <= 0) return;
    await showSearch(
      context: context,
      delegate: _SearchCatchableDelegate(_data, (context.widget as CatchableGrid).onItemTap)
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: <Widget>[
          Container (
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              highlightedBorderColor: Theme.of(context).primaryColor,
              onPressed: () => this._onSearchTap(context, this._data),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text('搜索', style: Theme.of(context).textTheme.display2,),
            ),
          ),
          Expanded(
            child: StoreConnector<AppState, CatchableViewModal>(
              distinct: true,
              converter: widget.converter,
              onInit: (store) => store.dispatch(widget.fetchData()),
              builder: (context, vm) {
                if (vm.fetching) {
                  return Text('loading');
                }

                _data = vm.data;
                return (GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1.0),
                  itemBuilder: (context, index) {
                    return GridCard(
                        onTap: widget.onItemTap, catchable: vm.data[index]);
                  },
                  itemCount: vm.data.length,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SearchCatchableDelegate extends SearchDelegate<Catchable> {
  List<Catchable> _data;
  Function(BuildContext, Catchable) _onItemTap;
  _SearchCatchableDelegate(List<Catchable> _data, Function(BuildContext, Catchable) tap) {
    this._data = _data;
    this._onItemTap = tap;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Catchable> suggestions = query.isEmpty
      ? []
      : this._data?.where((el) => el.name.contains(query)).toList();
    print(suggestions);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            close(context, null);
            this._onItemTap(context, this._data[index]);
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(suggestions[index].name, style: Theme.of(context).textTheme.display2,),
                Divider(color: Colors.grey,)
              ],
            )
          ),
        );
      }
    );
  }
  
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


