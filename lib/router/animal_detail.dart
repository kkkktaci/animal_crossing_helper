import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AnimalDetail extends StatelessWidget {
  Animal animal;
  AnimalDetail({this.animal});

  @override
  Widget build(BuildContext context) {
    animal = ModalRoute.of(context).settings.arguments as Animal;

    return StoreConnector<AppState, _AnimalViewModel>(
      distinct: true,
      converter: (store) => _AnimalViewModel(
          animal: store.state.animal.animal
              .singleWhere((item) => item.name == animal.name)),
      onInit: (store) => store.dispatch(fetchAnimalDetailIfNeeded(animal.name)),
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text(animal.name, style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              InkWell(
                customBorder: CircleBorder(side: BorderSide()),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.favorite, color: vm.animal.isMarked ? Colors.red[200] : Colors.white,)),
                  onTap: () {
                    if (this.animal != null) {
                      StoreProvider.of<AppState>(context)?.dispatch(ToggleAnimalMark(name: this.animal.name));
                    }
                  },
              )
            ],
          ),
          body: Container(
            color: Colors.green[100],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Scrollbar(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: 'avatar_image_${animal.name}',
                      child: Image(
                        width: 100.0,
                        height: 100.0,
                        image: CachedNetworkImageProvider(animal.image)
                      ),
                    ),
                    _buildInfo(context, vm)
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }

  Widget _buildInfo(BuildContext context, _AnimalViewModel vm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          // name
          _buildContainer(
              child: Center(
            child: Text(
              '${animal.name} ${animal.sex}',
              style: Theme.of(context).textTheme.display1,
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildTitleInfo(context, '生日', animal.birthday, true),
              _buildTitleInfo(context, '性格', animal.nature, true)
            ],
          ),
          _buildTitleInfo(context, '种族', animal.race, false),
          _buildTitleInfo(context, '口头禅', animal.byword, false),
          _buildTitleInfo(context, '目标', vm.animal.goal, false),
          _buildMotto(context, vm.animal.motto),
          _buildTitleInfo(context, '外文名称', vm.animal.foreignWord, false),
        ],
      ),
    );
  }

  Widget _buildContainer({Widget child}) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: child);
  }

  Widget _buildTitleInfo(
      BuildContext context, String title, String content, bool halfSize) {
    var size = MediaQuery.of(context).size.width / (halfSize ? 2.2 : 1);
    return Container(
        margin: EdgeInsets.only(top: 8),
        width: size,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // title
                Container(
                  width: size / 3,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.display3,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      content == null ? '正在加载' : content,
                      style: Theme.of(context).textTheme.display1,
                      maxLines: 1,
                    ))
              ],
            )));
  }

  Widget _buildMotto(BuildContext context, String motto) {
    var size = MediaQuery.of(context).size.width;
    return Container(
      width: size,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size,
            decoration: BoxDecoration(
              color: Colors.green[200],
            ),
            child: Center(
                child: Text(
              '座右铭',
              style: Theme.of(context).textTheme.display3,
            )),
          ),
          Text(
            motto == null ? '正在加载' : motto,
            style: Theme.of(context).textTheme.display1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

class _AnimalViewModel {
  Animal animal;

  _AnimalViewModel({this.animal});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _AnimalViewModel &&
          runtimeType == other.runtimeType &&
          animal == other.animal;

  @override
  int get hashCode => animal.hashCode;
}
