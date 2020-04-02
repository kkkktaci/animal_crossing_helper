import 'package:animal_crossing_helper/widgets/animal/animal_list.dart';
import 'package:animal_crossing_helper/widgets/fish/fish_list.dart';
import 'package:animal_crossing_helper/widgets/insect/insect_list.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    // 想要保持state的话，加AutomaticKeepAliveClientMixin的同时也需要加super.build
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        // TODO: 需要一个leading图标
        title: Text('Animal Crossing Helper', style: TextStyle(color: Colors.white)),
        // actions: _buildAppBarActions(),
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