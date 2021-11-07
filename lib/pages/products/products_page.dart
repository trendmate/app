import 'package:trendmate/pages/favourites/favourites_page.dart';
import 'package:trendmate/providers/products_provider.dart';
import 'package:trendmate/providers/boards_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trendmate/pages/products/filters_screen.dart';

class ProductsPage extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final titleController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    super.dispose();
  }

  void newBoard() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  height: 200,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New Board",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      Row(
                        children: [
                          Consumer<BoardsProvider>(
                            builder: (BuildContext context, boardsprovider,
                                Widget? child) {
                              return TextButton(
                                  onPressed: () {
                                    boardsprovider
                                        .createNewBoard(titleController.text)
                                        .then((value) =>
                                            Navigator.of(context).pop());
                                  },
                                  child: Text("Create"));
                            },
                          )
                        ],
                      )
                    ],
                  )),
            ),
          );
        });
  }

  // ignore: long-method
  void bottomModalSheet(String productId) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Consumer<BoardsProvider>(
              builder: (BuildContext context, boardsprovider, Widget? child) {
            return Container(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Save product to..."),
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  newBoard();
                                },
                                icon: Icon(Icons.add),
                                label: Text("New Board"))
                          ]),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Container(
                      height: 120,
                      child: boardsprovider.boardsList.isEmpty
                          ? Center(
                              child: Text("No boards created yet"),
                            )
                          : ListView.builder(
                              itemCount: boardsprovider.boardsList.length,
                              itemBuilder: (ctx, idx) {
                                final boardId =
                                    boardsprovider.boardsList[idx].boardId;
                                // ignore: newline-before-return
                                return CheckboxListTile(
                                    title: Text(
                                        boardsprovider.boardsList[idx].title),
                                    value: boardsprovider
                                        .boardsOfProduct(productId)
                                        .contains(boardId),
                                    onChanged: (bool? value) {
                                      if (value == true) {
                                        boardsprovider.addSingleProduct(
                                            boardId!, productId);
                                      } else
                                        boardsprovider.removeSingleProduct(
                                            boardId!, productId);
                                    });
                              }),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Done")),
                    )
                  ],
                ));
          });
        });
  }

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
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed(FavouritesPage.routeName);
            },
            color: Colors.black,
            iconSize: 25,
          ),
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
      body: SafeArea(
        child: Consumer<ProductsProvider>(
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
                  // child: ProductWidget(idx),
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
                                  productsProvider.products[idx].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              child: Text(productsProvider.products[idx].title),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10, bottom: 10),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    clipBehavior: Clip.hardEdge,
                                    child: Text(
                                      "Rs. ${productsProvider.products[idx].price.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[600]),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      color: Colors.teal[400],
                                      icon: Icon(Icons.library_add),
                                      onPressed: () {
                                        bottomModalSheet(productsProvider
                                            .products[idx].productId);
                                      },
                                    ),
                                    IconButton(
                                        color: Colors.red,
                                        icon: Icon(productsProvider.favoritesSet
                                                .contains(productsProvider
                                                    .products[idx].productId)
                                            ? Icons.favorite
                                            : Icons.favorite_border),
                                        onPressed: () {
                                          if (productsProvider.favoritesSet
                                              .contains(productsProvider
                                                  .products[idx].productId)) {
                                            productsProvider.removeFavorites(
                                                productsProvider
                                                    .products[idx].productId);
                                          } else {
                                            productsProvider.addFavorites(
                                                productsProvider
                                                    .products[idx].productId);
                                          }
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
