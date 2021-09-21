import 'package:app/providers/products_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/pages/home_page.dart';
import 'package:app/pages/filters_screen.dart';

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
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'TrendMate',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
            home: const HomePage(),
            routes: {
              FilterScreen.routeName: (ctx) => FilterScreen(),
            },
          );
        }));
  }
}
