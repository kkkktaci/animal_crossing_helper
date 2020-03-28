import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  Function(BuildContext, NameThing) onTap;
  NameThing nameThing;
  GridCard({this.onTap, this.nameThing});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => this.onTap(context, nameThing),
        child: Column(
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
      ),
    );
  }
}