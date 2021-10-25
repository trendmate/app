import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/providers/products_provider.dart';

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
              return Card(
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            //alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.network(
                              productsProvider.favorites[idx].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          child: Text(productsProvider.favorites[idx].title),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                "Rs.${productsProvider.favorites[idx].price.toString()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[600]),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                color: Colors.red,
                                icon: Icon(productsProvider.favoritesMap
                                        .containsKey(productsProvider
                                            .favorites[idx].productId)
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                                onPressed: () =>
                                    productsProvider.addRemoveFavorites(idx),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              );
            }),
      );
    }
  }
}
