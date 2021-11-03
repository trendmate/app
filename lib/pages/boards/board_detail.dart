import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/providers/boards_provider.dart';
import 'package:trendmate/providers/products_provider.dart';

class BoardDetail extends StatefulWidget {
  // const BoardDetail({Key? key}) : super(key: key);
  static const routeName = "/board-detail";

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  @override
  Widget build(BuildContext context) {
    // BoardIndex will get us the Board we want to display
    final BoardIndex = ModalRoute.of(context)!.settings.arguments as int;
    final boardsProvider = Provider.of<BoardsProvider>(context);
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(boardsProvider.boardsList[BoardIndex].title),
      ),
      body: boardsProvider.boardsList[BoardIndex].favorites.isEmpty
          ? Center(
              child: Text(
                  "${boardsProvider.boardsList[BoardIndex].title} is empty"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.5),
              itemCount: boardsProvider.boardsList[BoardIndex].favorites.length,
              itemBuilder: (ctx, idx) {
                var product = productsProvider.products.firstWhere((element) =>
                    element.productId ==
                    boardsProvider.boardsList[BoardIndex].favorites[idx]);

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
                                                .boardsList[BoardIndex].boardId,
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
                );
              }),
    );
  }
}
