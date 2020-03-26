import 'package:animal_crossing_helper/widgets/fish/fish_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentBottomIndex = 0;
  final BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  final PageController _pageController = PageController();

  final _contents = [
    FishList(),
    Container(width: 300, height: 300, color: Colors.green,),
    Container(width: 300, height: 300, color: Colors.blue,),
  ];



  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => {}
      )
    ];
  }

  List<BottomNavigationBarItem> _buildBottomBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.fish),
        title: Text('Fish')
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.fish),
        title: Text('Insect')
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.fish),
        title: Text('npc')
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: 需要一个leading图标
        title: Text('Animal Crossing Helper', style: TextStyle(color: Colors.white)),
        actions: _buildAppBarActions(),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _contents,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _currentBottomIndex,
        type: _type,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: _buildBottomBarItems(),
        onTap: _onBottomBarTap,
      ),
    );
  }
}