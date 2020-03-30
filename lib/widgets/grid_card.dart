import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  Function(BuildContext, NameThing) onTap;
  Function(NameThing) buildMark;
  NameThing nameThing;
  GridCard({this.onTap, this.nameThing, this.buildMark});

  Widget _buildMark() {
    if (this.buildMark == null) return null;
    var buildWidget = this.buildMark(nameThing);
    if (buildWidget == null) return null;
    return Positioned(top: 8, right: 8, child: buildWidget);
  }

  List<Widget> _buildContent(BuildContext context) {
    List<Widget> content = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Image(
              image: CachedNetworkImageProvider(nameThing.image),
              width: 60.0,
              height: 60.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              nameThing.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.display1,
            ),
          )
        ],
      ),
      // mark icon
      _buildMark()
    ];
    return content.where((w) => w != null).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => this.onTap(context, nameThing),
        child: Stack(
          alignment: Alignment.center,
          children: _buildContent(context),
        ),
      ),
    );
  }
}
