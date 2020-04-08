import 'package:animal_crossing_helper/delegate/search_name_thing_delegate.dart';
import 'package:animal_crossing_helper/delegate/sliver_search_bar_delegate.dart';
import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:animal_crossing_helper/widgets/birthday_notification.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
import 'package:animal_crossing_helper/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';

class AnimalListPresentation extends StatelessWidget {
  final AnimalViewModel vm;
  AnimalListPresentation({Key key, this.vm}) : super(key: key);

  List<Animal> _data;

  void _gotoDetail(BuildContext context, NameThing catchable) {
    Navigator.of(context).pushNamed('/animal_detail', arguments: catchable);
  }

  void _onSearchTap(BuildContext context) async {
    if (_data.length <= 0) return;
    await showSearch(
      context: context,
      delegate: SearchNameThingDelegate(_data, _gotoDetail)
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.red,
    );
  }

  Widget _buildMark(NameThing animal) {
    if (!(animal as Animal).isMarked) return null;
    return Icon(Icons.favorite, color: Colors.red[200],);
  }

  @override
  Widget build(BuildContext context) {
    if (vm.fetching && vm.data.length == 0) {
      return Loading();
    }
    
    this._data = vm.data;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          floating: true,
          // delegate: SliverSearchBarDelegate(onTap: this._onSearchTap, bottomSheet: _buildBottomSheet(context))
          delegate: SliverSearchBarDelegate(onTap: this._onSearchTap)
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.0),
          delegate: SliverChildBuilderDelegate((context, index) {
            return GridCard(
              onTap: _gotoDetail,
              nameThing: _data[index],
              buildMark: _buildMark,
            );
          },
          childCount: _data.length)
        )
      ],
    );
  }
}

class AnimalList extends StatefulWidget {
  @override
  _AnimalListState createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print('>>>> build animal list');
    super.build(context);
    return StoreConnector<AppState, AnimalViewModel>(
      distinct: true,
      converter: AnimalViewModel.fromStore,
      onInit: (store) => store.dispatch(fetchAnimalList(showBirthdayNotification)),
      builder: (context, vm) {
        return AnimalListPresentation(
          vm: vm,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AnimalViewModel {
  bool fetching;
  List<Animal> data;
  Object error;
  // FilterState filter;

  AnimalViewModel({this.fetching, this.data, this.error});

  static AnimalViewModel fromStore(Store<AppState> store) =>
    AnimalViewModel(fetching: store.state.animal.fetching, data: store.state.animal.animal, error: store.state.animal.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalViewModel &&
          runtimeType == other.runtimeType &&
          fetching == other.fetching &&
          data == other.data &&
          error == other.error;

  @override
  int get hashCode => fetching.hashCode ^ data.hashCode ^ error.hashCode;
}
