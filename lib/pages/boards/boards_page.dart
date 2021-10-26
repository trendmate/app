import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/pages/boards/board_detail.dart';
import 'package:trendmate/providers/boards_provider.dart';

class BoardsPage extends StatelessWidget {
  static const routeName = '/boards-page';
  const BoardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardsProvider = Provider.of<BoardsProvider>(context);
    boardsProvider.dummyInit();
    final keys = boardsProvider.boardsMap.keys.toList();
    // print(boardsProvider.boardsMap["1"]);
    if (boardsProvider.boardsMap.isEmpty) {
      return Center(
        child: Text("No boards to show!"),
      );
    } else {
      return ListView.builder(
        // itemCount: boardsProvider.boardsMap.length,
        itemCount: keys.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(BoardDetail.routeName, arguments: keys[index]);
          },
          child: Card(
            child: ListTile(
              leading: boardsProvider.boardsMap[keys[index]]!.image == ''
                  ? Image.network(
                      "https://i.ebayimg.com/images/g/am8AAOSw4m9b~Bks/s-l400.jpg")
                  : Image.network(boardsProvider.boardsMap[index]!.image),
              title: Row(
                children: [
                  Text(
                    boardsProvider.boardsMap[keys[index]]!.title,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.people),
                  Text(boardsProvider.boardsMap[keys[index]]!.followers.toString()),
                ],
              ),
              subtitle: Text(
                boardsProvider.boardsMap[keys[index]]!.description,
                overflow: TextOverflow.ellipsis,
              ),
              // trailing: Text(boardsProvider.boardsMap[index].by),
            ),
          ),
        ),
      );
    }
  }
}
