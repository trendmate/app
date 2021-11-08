import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/models/ecom/product.dart';
import 'package:trendmate/models/social/board.dart';
import 'package:trendmate/providers/boards_provider.dart';
import 'package:trendmate/providers/products_provider.dart';
import 'package:trendmate/services/firebase_methods.dart';

class BoardDetail extends StatefulWidget {
  // const BoardDetail({Key? key}) : super(key: key);
  static const routeName = "/board-detail";

  final Board? toDisplay;

  const BoardDetail({Key? key, this.toDisplay}) : super(key: key);

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  @override
  Widget build(BuildContext context) {
    // BoardIndex will get us the Board we want to display
    final boardIndex = (ModalRoute.of(context)!.settings.arguments ?? 0) as int;
    final boardsProvider = Provider.of<BoardsProvider>(context);
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    Board _board = widget.toDisplay == null
        ? boardsProvider.boardsList[boardIndex]
        : widget.toDisplay!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(_board.title),
      ),
      body: _board.favorites.isEmpty
          ? Center(child: Text("${_board.title} is empty"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.5),
              itemCount: _board.favorites.length,
              itemBuilder: (ctx, idx) {
                // var product = productsProvider.products.firstWhere(
                //     (element) => element.productId == _board.favorites[idx]);

                return FutureBuilder<Product>(
                  future: FirebaseMethods.instance.getProduct(_board.favorites[idx]),
                  builder: (context, snapshot) {
                    final product = snapshot.data;
                    if(product==null) return CircularProgressIndicator();
                    
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
                                  product.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              child: Text(product.title),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, bottom: 10),
                                  child: Text(
                                    "Rs. ${product.price.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[600]),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Theme.of(context).errorColor),
                                        onPressed: () {
                                          boardsProvider.removeSingleProduct(
                                              boardsProvider
                                                  .boardsList[boardIndex]
                                                  .boardId!,
                                              product.productId);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ]),
                    ),
                  );}
                );
              }),
    );
  }
}
