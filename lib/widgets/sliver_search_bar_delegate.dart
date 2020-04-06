import 'package:flutter/material.dart';

class SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  Function onTap;
  Widget bottomSheet;
  SliverSearchBarDelegate({this.onTap, this.bottomSheet});

  Widget _buildButton(BuildContext context) {
    if (bottomSheet == null) return null;
    return FlatButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return bottomSheet;
          }
        );
      },
      child: Text('筛选', style: TextStyle(color: Theme.of(context).primaryColor),)
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    List<Widget> content = [
      Expanded(
        child: OutlineButton(
          highlightedBorderColor: Theme.of(context).primaryColor,
          onPressed: () => this.onTap(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text('搜索', style: Theme.of(context).textTheme.display2,),
        ),
      ),
      _buildButton(context)
    ];
    return content.where((item) => item != null).toList();
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container (
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      height: 50,
      child: Row(
        children: _buildContent(context)
      )
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}