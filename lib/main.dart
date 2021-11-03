import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/pages/auth/login_page.dart';
import 'package:trendmate/pages/auth/signup_page.dart';
import 'package:trendmate/pages/boards/board_detail.dart';
import 'package:trendmate/pages/boards/boards_page.dart';
import 'package:trendmate/pages/posts/post_detail.dart';
import 'package:trendmate/constants/config.dart';
import 'package:trendmate/providers/boards_provider.dart';
import 'package:trendmate/providers/filters_provider.dart';
import 'package:trendmate/providers/posts_provider.dart';
import 'package:trendmate/providers/products_provider.dart';

import 'package:trendmate/pages/products/products_page.dart';
import 'package:trendmate/pages/posts/posts_page.dart';
import 'package:trendmate/pages/favourites/favourites_page.dart';
import 'package:trendmate/pages/products/filters_screen.dart';
import 'package:trendmate/pages/tabs_page.dart';
import 'package:trendmate/pages/social/social_page.dart';
import 'package:trendmate/providers/social_provider.dart';
import 'package:trendmate/providers/user_provider.dart';

void main() async {
  Config.UItest = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => UserProvider(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => ProductsProvider(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => FiltersProvider(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => BoardsProvider(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => PostsProvider(),
          ),
          ChangeNotifierProxyProvider<UserProvider, SocialProvider>(
            lazy: false,
            create: (ctx) => SocialProvider(),
            update: (context, value, previous) => SocialProvider(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'TrendMate',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              fontFamily: 'Poppins',
            ),
            home: Consumer<UserProvider>(
              builder: (BuildContext context, value, Widget? child) =>
                  value.user == null ? LoginPage() : TabsPage(),
            ),
            // home: TabsPage(),
            // home: SignUpPage(),
            routes: {
              SignUpPage.routeName: (ctx) => SignUpPage(),
              LoginPage.routeName: (ctx) => LoginPage(),
              //OtpPage.routeName: (ctx) => OtpPage(verId: '',),
              TabsPage.routeName: (ctx) => TabsPage(),
              FilterScreen.routeName: (ctx) => FilterScreen(),
              BoardsPage.routeName: (ctx) => BoardsPage(),
              BoardDetail.routeName: (ctx) => BoardDetail(),
              ProductsPage.routeName: (ctx) => ProductsPage(),
              PostsPage.routeName: (ctx) => PostsPage(),
              FavouritesPage.routeName: (ctx) => FavouritesPage(),
              SocialPage.routeName: (ctx) => SocialPage(),
              PostDetail.routeName: (ctx) => PostDetail(),
            },
          );
        }));
  }
}
