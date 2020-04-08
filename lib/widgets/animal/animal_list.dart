import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
import 'package:animal_crossing_helper/widgets/search_name_thing_delegate.dart';
import 'package:animal_crossing_helper/widgets/sliver_search_bar_delegate.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';

class AnimalList extends StatefulWidget {
  @override
  _AnimalListState createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> with AutomaticKeepAliveClientMixin {
  List<Animal> _data;
  bool _enableSlideOff = true;
  bool _onlyOne = true;
  bool _crossPage = true;
  int _seconds = 10;
  int _animationMilliseconds = 200;
  int _animationReverseMilliseconds = 200;
  BackButtonBehavior _backButtonBehavior = BackButtonBehavior.none;

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

  void _showBirthdayNotification(List<NameThing> data) {
    var dateTime = DateTime.now();
    var today = '${dateTime.month}月${dateTime.day}日';
    List<Animal> result = data.where((item) => (item as Animal).birthday.contains(today)).toList();
    if (result.length < 1) return;
    BotToast.showCustomNotification(
      animationDuration: Duration(milliseconds: _animationMilliseconds),
      animationReverseDuration: Duration(milliseconds: _animationReverseMilliseconds),
      duration: Duration(seconds: _seconds),
      backButtonBehavior: _backButtonBehavior,
      enableSlideOff: _enableSlideOff,
      onlyOne: _onlyOne,
      crossPage: _crossPage,
      toastBuilder: (cancel) {
        return _buildNotification(result);
      }
    );
  }

  Widget _buildNotification (List<Animal> animal) {
    InlineSpan leadingSpan = TextSpan(text: '今天是 ');
    InlineSpan tearSpan = TextSpan(text: ' 的生日哦!');
    String names = animal.map((item) => item.name).toList().join(', ');
    List<InlineSpan> content = [
      leadingSpan,
      TextSpan(text: names, style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold)),
      tearSpan
    ];

    // 查找今天的生日中是否有关注的小动物
    String islanderString;
    List<Animal> markAnimal = animal.where((item) => item.isMarked).toList();
    if (markAnimal.length > 0) {
      islanderString = markAnimal.map((item) => item.name).toList().join(',');
      content.addAll([
        TextSpan(text: '\n'),
        TextSpan(text: '其中 '),
        TextSpan(text: islanderString, style: TextStyle(color: Colors.red[200], fontWeight: FontWeight.bold)),
        TextSpan(text: ' 是你关注的哦!')
      ]);
    }

    return Material(
      elevation: 8,
      borderRadius: BorderRadiusDirectional.all(Radius.circular(16)),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 600,
        height: 100,
        child: Text.rich(TextSpan(
          children: content
        ))
      ),
    );
  }

  Widget _buildMark(NameThing animal) {
    if (!(animal as Animal).isMarked) return null;
    return Icon(Icons.favorite, color: Colors.red[200],);
  }

  @override
  Widget build(BuildContext context) {
    print('>>>> build animal list');
    super.build(context);
    return StoreConnector<AppState, AnimalViewModel>(
      distinct: true,
      converter: AnimalViewModel.fromStore,
      onInit: (store) => store.dispatch(fetchAnimalList(_showBirthdayNotification)),
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
