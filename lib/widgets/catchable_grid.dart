import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
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

  List<NameThing> _data;

  void _onSearchTap() async {
    if (_data.length <= 0) return;
    await showSearch(
      context: context,
      delegate: _SearchCatchableDelegate(_data, widget.onItemTap)
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, NameThingViewModal>(
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

        this._data = vm.data;
        return CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              delegate: SliverSearchBarDelegate(onTap: this._onSearchTap)
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverFiltersDeletegate()
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.0),
              delegate: SliverChildBuilderDelegate((context, index) {
                return GridCard(
                  onTap: widget.onItemTap,
                  nameThing: vm.data[index],
                  buildMark: widget.buildMark,
                );
              },
              childCount: vm.data.length)
            )
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  Function onTap;
  SliverSearchBarDelegate({this.onTap});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container (
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      height: 50,
      child: OutlineButton(
        highlightedBorderColor: Theme.of(context).primaryColor,
        onPressed: () => this.onTap(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text('搜索', style: Theme.of(context).textTheme.display2,),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SliverFiltersDeletegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      color: Colors.red,
    );
  }

  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 45;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
  
}

class _SearchCatchableDelegate extends SearchDelegate<NameThing> {
  List<NameThing> _data;
  Function(BuildContext, NameThing) _onItemTap;
  _SearchCatchableDelegate(List<NameThing> _data, Function(BuildContext, NameThing) tap) {
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
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }
  
  Widget _buildList(BuildContext context) {
    List<NameThing> result = query.isEmpty
          ? []
          : this._data?.where((el) => el.name.contains(query)).toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            close(context, null);
            this._onItemTap(context, result[index]);
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(result[index].name, style: Theme.of(context).textTheme.display2,),
                Divider(color: Colors.grey,)
              ],
            )
          ),
        );
      }
    );
  }
}

class NameThingViewModal {
  bool fetching;
  List<NameThing> data;
  Object error;

  NameThingViewModal({this.fetching, this.data, this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameThingViewModal &&
          runtimeType == other.runtimeType &&
          fetching == other.fetching &&
          data == other.data &&
          error == other.error;

  @override
  int get hashCode => fetching.hashCode ^ data.hashCode ^ error.hashCode;
}


