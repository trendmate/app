import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/constants/config.dart';
import 'package:trendmate/providers/filters_provider.dart';
import 'package:trendmate/providers/products_provider.dart';

import 'package:trendmate/pages/products/products_page.dart';
import 'package:trendmate/pages/posts/posts_page.dart';
import 'package:trendmate/pages/favourites/board_page.dart';
import 'package:trendmate/pages/products/filters_screen.dart';
import 'package:trendmate/pages/tabs_page.dart';
import 'package:trendmate/pages/social/social_page.dart';
import 'package:trendmate/providers/social_provider.dart';
import 'package:trendmate/providers/user_provider.dart';

void main() async {
  Config.UItest = true;
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
            create: (ctx) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ProductsProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => FiltersProvider(),
          ),
          ChangeNotifierProxyProvider<UserProvider, SocialProvider>(
            create: (ctx) => SocialProvider(),
            update: (context, value, previous) => SocialProvider(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'TrendMate',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
            home: const TabsPage(),
            routes: {
              FilterScreen.routeName: (ctx) => FilterScreen(),
              ProductsPage.routeName: (ctx) => ProductsPage(),
              PostsPage.routeName: (ctx) => PostsPage(),
              FavouritesPage.routeName: (ctx) => FavouritesPage(),
              SocialPage.routeName: (ctx) => SocialPage(),
            },
          );
        }));
  }
}
