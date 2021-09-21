import 'package:trendmate/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trendmate/pages/filters_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        elevation: 0,
        title: Text(
          "Top Trending",
          style: TextStyle(color: Colors.black, fontSize: 21),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(16),
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(FilterScreen.routeName);
            },
            color: Colors.black,
            iconSize: 30,
          )
        ],
      ),
      body: Consumer<ProductsProvider>(
        builder: (BuildContext context, productsProvider, Widget? child) =>
            GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.5),
                itemCount: productsProvider.products.length,
                itemBuilder: (ctx, idx) {
                  return GestureDetector(
                    child: Card(
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
                                    productsProvider.products[idx].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                child:
                                    Text(productsProvider.products[idx].name),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, bottom: 10),
                                child: Text(
                                  "Rs.${productsProvider.products[idx].price.toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[600]),
                                ),
                              )
                            ]),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
