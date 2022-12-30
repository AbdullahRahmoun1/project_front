import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';
import '../providers/categories.dart';
import '../screen/seach_screen.dart';
import '../screen/favorit_screen.dart';
import '../screen/home_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  static const routName = '/tabs';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'page': SearchScreen(),
        'title': 'Search page',
      },
      {
        'page': HomeSceen(),
        'title': 'Home page',
      },
      {'page': FavoritScreen(), 'title': 'Your favorites'},
    ];
    super.initState();
  }

  int _selectedPageIndex = 1;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color.fromARGB(255, 107, 73, 164),
        color: Color.fromARGB(255, 107, 73, 164),
        animationCurve: Curves.easeInOut,
        index: 1,
        animationDuration: Duration(milliseconds: 200),
        height: 50,
        items: const [
          Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
