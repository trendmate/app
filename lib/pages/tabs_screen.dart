import 'package:flutter/material.dart';

import 'blogs_page.dart';
import 'favourites_page.dart';
import 'home_page.dart';
import 'filters_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': HomePage(), 'title': 'Feed'},
      {'page': FavouritesPage(), 'title': 'Review'},
      {'page': BlogsPage(), 'title': 'Statistics'},
    ];
    // TODO: implement initState
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: Colors.blue,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favourites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mobile_friendly), label: 'Blog'),
        ],
      ),
    );
  }
}
