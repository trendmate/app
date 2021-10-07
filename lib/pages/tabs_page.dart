import 'package:flutter/material.dart';
import 'package:trendmate/pages/social/social_page.dart';

import 'posts/posts_page.dart';
import 'favourites/board_page.dart';
import 'products/products_page.dart';

class TabsPage extends StatefulWidget {
  static const routeName = '/tabs-screen';
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': ProductsPage(), 'title': 'Home'},
      {'page': FavouritesPage(), 'title': 'Favourites'},
      {'page': PostsPage(), 'title': 'Posts'},
      {'page': SocialPage(), 'title': 'Social'},
    ];
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mobile_friendly),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Social',
          )
        ],
      ),
    );
  }
}
