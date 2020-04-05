import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:flutter/material.dart';

class SearchNameThingDelegate extends SearchDelegate<NameThing> {
  List<NameThing> _data;
  Function(BuildContext, NameThing) _onItemTap;
  SearchNameThingDelegate(List<NameThing> _data, Function(BuildContext, NameThing) tap) {
    this._data = _data;
    this._onItemTap = tap;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
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