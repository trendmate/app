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
                  "Rs.${productsProvider.products[widget.idx].price.toString()}",
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
                      // TODO
                    },
                  )),
                  Container(
                    child: IconButton(
                      color: Colors.red,
                      icon: Icon(productsProvider.favoritesMap
                              .containsKey(productsProvider
                                  .products[widget.idx].productId)
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () => productsProvider
                          .addRemoveFavorites(widget.idx),
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
