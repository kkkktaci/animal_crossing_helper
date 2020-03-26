import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CatchableDetail extends StatelessWidget {
  Catchable catchable;
  Widget extra;
  CatchableDetail({this.catchable, this.extra});

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.green[100],
            width: 100,
            height: 30,
            padding: EdgeInsets.only(left: 16),
            alignment: AlignmentDirectional.centerStart,
            child: Text(title),
          ),
          Container(
              height: 30,
              padding: EdgeInsets.only(left: 6),
              alignment: AlignmentDirectional.centerStart,
              child: Text(content)),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _buildInfoRow('价格', catchable.price),
          _buildInfoRow('捕获位置', catchable.activePlace),
          _buildInfoRow('北半球月份', '${catchable.north.first} - ${catchable.north.last}'),
          _buildInfoRow('南半球月份', '${catchable.south.first} - ${catchable.south.last}'),
          _buildInfoRow('出现时间', '${catchable.time.first} - ${catchable.time.last}'),
          _buildInfoRow('影子大小', catchable.extra),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    catchable = ModalRoute.of(context).settings.arguments as Catchable;
    return Scaffold(
      appBar: AppBar(
        title: Text(catchable.name),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                      width: 100.0,
                      height: 100.0,
                      image: CachedNetworkImageProvider(catchable.image)),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 25,
                    color: Colors.grey[200],
                    child: Center(
                      child: Text('基本信息'),
                    ),
                  ),
                  _buildInfo(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
