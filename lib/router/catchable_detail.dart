import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CatchableDetail extends StatelessWidget {
  Catchable catchable;
  Widget extra;
  CatchableDetail({this.catchable, this.extra});

  Widget _buildInfoRow(BuildContext context, String title, String content) {
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
            child: Text(title, style: Theme.of(context).textTheme.display1,),
          ),
          Container(
              height: 30,
              padding: EdgeInsets.only(left: 6),
              alignment: AlignmentDirectional.centerStart,
              child: Text(content, style: Theme.of(context).textTheme.display1,)),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _buildInfoRow(context, '价格', catchable.price),
          _buildInfoRow(context, '捕获位置', catchable.activePlace),
          _buildInfoRow(context, '北半球月份', '${catchable.north.first} - ${catchable.north.last}'),
          _buildInfoRow(context, '南半球月份', '${catchable.south.first} - ${catchable.south.last}'),
          _buildInfoRow(context, '出现时间', '${catchable.time.first} - ${catchable.time.last}'),
          _buildInfoRow(context, this.catchable.type == TYPE.FISH ? '鱼影大小' : '出现天气', catchable.extra),
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
                      child: Text('基本信息', style: Theme.of(context).textTheme.display2,),
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
