import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/providers/boards_provider.dart';
import 'package:trendmate/widgets/product_widget.dart';

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
    final BoardKey = ModalRoute.of(context)!.settings.arguments as String;
    final boardsProvider = Provider.of<BoardsProvider>(context);
    final imageKeys =
        boardsProvider.boardsMap[BoardKey]!.favorites.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          boardsProvider.boardsMap[BoardKey]!.title,
          style: TextStyle(color: Colors.black, fontSize: 21),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 500,
              width: double.infinity,
              child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.5),
                  itemCount: imageKeys.length,
                  itemBuilder: (ctx, idx) {
                    return ProductWidget(idx);
                  }),
            ),
            // show no. of shares
            // Row(
            //   children: [
            //     Icon(Icons.people),
            //     Text(boardsProvider.boardsMap[BoardKey]!.followers.toString()),
            //   ],
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // // description
            // Text(boardsProvider.boardsMap[BoardKey]!.description),
            // SizedBox(
            //   height: 5,
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   "Tags: ",
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(
            //   height: 30,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       shrinkWrap: true,
            //       itemCount: boardsProvider.boardsMap[BoardKey]!.tags.length,
            //       itemBuilder: (ctx, i) => Card(
            //           color: Colors.blue,
            //           child: Text(boardsProvider.boardsMap[BoardKey]!.tags[i],
            //               style: TextStyle(color: Colors.white)))),
            // ),
          ],
        ),
      ),
    );
  }
}
