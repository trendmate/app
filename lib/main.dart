import 'package:trendmate/providers/products_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trendmate/pages/home_page.dart';
import 'pages/blogs_page.dart';
import 'pages/favourites_page.dart';
import 'package:trendmate/pages/filters_screen.dart';
import 'providers/filters_provider.dart';
import 'pages/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => ProductsProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => FiltersProvider(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'TrendMate',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
            home: const TabsScreen(),
            routes: {
              FilterScreen.routeName: (ctx) => FilterScreen(),
              HomePage.routeName: (ctx) => HomePage(),
              BlogsPage.routeName: (ctx) => BlogsPage(),
              FavouritesPage.routeName: (ctx) => FavouritesPage(),
            },
          );
        }));
  }
}
