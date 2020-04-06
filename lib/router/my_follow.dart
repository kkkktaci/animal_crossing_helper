import 'dart:ui';

import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/redux/animal/animal_actions.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyFollow extends StatefulWidget {
  @override
  _MyFollowState createState() => _MyFollowState();
}

class _MyFollowState extends State<MyFollow> {
  @override
  Widget build(BuildContext context) {
    List<Animal> animal = getAllMyFollowAnimal(context);
    return Scaffold(
      appBar: AppBar(title: Text('正在关注的村民', style: TextStyle(color: Colors.white)),),
      body: _buildBody(animal)
    );
  }

  Widget _buildBody(List<Animal> animal) {
    if (animal.length == 0) {
      return Container(
        child: Center(
          child: Text('未获取村民数据'),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16),
      itemCount: animal.length,
      itemBuilder: (context, index) {
        Animal item = animal[index];
        return FollowItem(animal: item);
      }
    );
  }
}

class FollowItem extends StatefulWidget {
  Animal animal;
  FollowItem({this.animal});

  @override
  _FollowItemState createState() => _FollowItemState();
}

class _FollowItemState extends State<FollowItem> {
  bool isFollow;
  @override
  void initState() {
    isFollow = widget.animal.isMarked;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image(image: CachedNetworkImageProvider(widget.animal.image)),
      ),
      title: Text(widget.animal.name),
      subtitle: Text(widget.animal.birthday, style: TextStyle(fontSize: 12),),
      trailing: OutlineButton(
        highlightedBorderColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryColor,
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: () {
          StoreProvider.of<AppState>(context).dispatch(ToggleAnimalMark(name: widget.animal.name));
          setState(() {
            isFollow = !isFollow;
          });
        },
        child: Text(isFollow ? '取消' : '关注')
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/animal_detail', arguments: widget.animal);
      },
    );
  }
}