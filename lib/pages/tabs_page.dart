import 'package:flutter/material.dart';
import 'package:trendmate/pages/boards/boards_page.dart';
import 'package:trendmate/pages/social/social_page.dart';
import 'package:trendmate/pages/social/social_search.dart';

import 'posts/posts_page.dart';
import 'favourites/favourites_page.dart';
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
      {'page': BoardsPage(), 'title': 'Boards'},
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
      appBar: _selectedPageIndex != 0 ? AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Row(
          children: [
            Text(
              _pages[_selectedPageIndex]['title'].toString(),
              style: TextStyle(color: Colors.black, fontSize: 21),
            ),
            if (_selectedPageIndex == 4)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => SocialSearch()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 8, 8, 8),
                    child: Row(
                      children: [
                        Text("Search", style: TextStyle(color: Colors.grey)),
                        Spacer(),
                        Icon(Icons.search)
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ) : null,
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
            icon: Icon(Icons.library_add_check),
            label: 'Boards',
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
