import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/providers/products_provider.dart';
import 'package:trendmate/widgets/product_widget.dart';

class FavouritesPage extends StatefulWidget {
  static const routeName = '/favourites-page';
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    if (productsProvider.favorites.isEmpty) {
      return Center(
        child: Text("Favorites List is Empty!"),
      );
    } else {
      return Scaffold(
        body: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.5),
            itemCount: productsProvider.favorites.length,
            itemBuilder: (ctx, idx) {
              return ProductWidget(idx);
            }),
      );
    }
  }
}
