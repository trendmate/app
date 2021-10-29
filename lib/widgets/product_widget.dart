import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/providers/boards_provider.dart';
import 'package:trendmate/providers/products_provider.dart';

class ProductWidget extends StatefulWidget {
  // const ProductWidget({Key? key}) : super(key: key);
  // final ProductsProvider productsProvider;
  final int idx;
  ProductWidget(this.idx);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  void _createAddRemoveBuilders(
      BuildContext ctx,
      ProductsProvider productsProvider,
      BoardsProvider boardsProvider,
      int productId) {
    Map<int, bool?> checked = {};
    Set<String> setOfBoards = boardsProvider
        .setOfBoards(productsProvider.products[productId].productId);
    List<String> allBoardIds = boardsProvider.allBoardIds();
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          // avoid reset on tap
          return StatefulBuilder(
            builder: (context, setState) => SizedBox(
              height: 700,
              child: Column(children: [
                IconButton(
                    onPressed: () {
                      // TODO PROMPT USER TO INPUT NAME OF NEW BOARD
                      setState(() {
                        boardsProvider.createNewBoard("name");
                      });
                    },
                    icon: Icon(Icons.add)),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: allBoardIds.length,
                    itemBuilder: (ctx, i) {
                      if (checked[i] == null)
                        checked[i] = setOfBoards.contains(allBoardIds[i]);

                      return ListTile(
                        leading: Checkbox(
                          value: checked[i]!,
                          onChanged: (bool? boolValue) {
                            setState(() {
                              if (checked[i]! == true) {
                                // Add that board to Maps
                                boardsProvider
                                    .addProductToBoard(
                                        productsProvider
                                            .products[productId].productId,
                                        allBoardIds[i])
                                    .then((value) => checked[i] = boolValue!);
                              } else {
                                // Remove that board from Maps
                                boardsProvider
                                    .removeProductFromBoard(
                                        productsProvider
                                            .products[productId].productId,
                                        allBoardIds[i])
                                    .then((value) => checked[i] = boolValue!);
                              }
                            });
                          },
                        ),
                        title: Text(allBoardIds[i]),
                      );
                    }),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final boardsProvider = Provider.of<BoardsProvider>(context);

    return Card(
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Container(
              //alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(
                productsProvider.products[widget.idx].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: Text(productsProvider.products[widget.idx].title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  "Rs. ${productsProvider.products[widget.idx].price.toString()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue[600]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      child: IconButton(
                    icon: Icon(Icons.library_add),
                    onPressed: () {
                      // TODO add remove collection dialog
                      return _createAddRemoveBuilders(context, productsProvider,
                          boardsProvider, widget.idx);
                    },
                  )),
                  Container(
                    child: IconButton(
                      color: Colors.red,
                      icon: Icon(productsProvider.favoritesMap.containsKey(
                              productsProvider.products[widget.idx].productId)
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () =>
                          productsProvider.addRemoveFavorites(widget.idx),
                    ),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
