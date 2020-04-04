import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/selector.dart';
import 'package:animal_crossing_helper/widgets/animal/animal_list.dart';
import 'package:animal_crossing_helper/widgets/fish/fish_list.dart';
import 'package:animal_crossing_helper/widgets/insect/insect_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

const Color SELECTED_COLOR = Color.fromARGB(255, 250, 217, 145);
const Color UNSELECTED_COLOR = Color.fromARGB(255, 128, 125, 115);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  int _currentBottomIndex = 0;
  final BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  final PageController _pageController = PageController();

  final _contents = [
    FishList(),
    InsectList(),
    AnimalList(),
  ];

  List<BottomNavigationBarItem> _buildBottomBarItems() {
    return [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/fish.png')),
        title: Text('鱼类')
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/butterfly.png')),
        title: Text('昆虫')
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/pawprint.png')),
        title: Text('村民')
      )
    ];
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentBottomIndex = index;
    });
  }

  void _onBottomBarTap(int index) {
    _pageController?.jumpToPage(index);
  }

  Widget _buildDrawerHeader(BuildContext context) {
    int count = getAllMyFollowAnimal(StoreProvider.of<AppState>(context).state).length;
    return Container(
      child: Stack(
        children: <Widget>[
           Positioned(
            bottom: 8,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/my_follow');
              },
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(text: '$count', style: Theme.of(context).textTheme.body1),
                    TextSpan(text: ' 位正在关注的村民', style: Theme.of(context).textTheme.body2)
                  ]
                )
              ),
            )
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // 想要保持state的话，加AutomaticKeepAliveClientMixin的同时也需要加super.build
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Crossing Helper', style: TextStyle(color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8),
          children: <Widget>[
            DrawerHeader(
              child: _buildDrawerHeader(context)
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('当月一览'),
              onTap: () {
                // 关闭抽屉
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/glance');
              },
            )
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _contents,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 248, 251, 226),
        currentIndex: _currentBottomIndex,
        type: _type,
        selectedItemColor: SELECTED_COLOR,
        unselectedItemColor: UNSELECTED_COLOR,
        items: _buildBottomBarItems(),
        onTap: _onBottomBarTap,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}