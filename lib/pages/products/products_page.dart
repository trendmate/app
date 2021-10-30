import 'package:trendmate/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/widgets/product_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trendmate/pages/favourites/favourites_page.dart';
import 'package:trendmate/pages/boards/boards_page.dart';
import 'package:trendmate/widgets/background.dart';
import 'package:trendmate/pages/products/filters_screen.dart';

class ProductsPage extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
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
      body: Stack(
        children: [
          BackgroundImage(),
          Consumer<ProductsProvider>(
            builder: (BuildContext context, productsProvider, Widget? child) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.5),
                itemCount: productsProvider.products.length,
                itemBuilder: (ctx, idx) {
                  return GestureDetector(
                    onTap: () async {
                      final _url = productsProvider.products[idx].url;
                      print(_url);
                      await canLaunch(_url)
                          ? await launch(_url)
                          : throw 'Could not launch $_url';
                    },
                    child: ProductWidget(idx),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
