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
    if (boardsProvider.boardsList.isEmpty) {
      return Center(
        child: Text("No boards to show!"),
      );
    } else {
      return ListView.builder(
        // itemCount: boardsProvider.boardsMap.length,
        itemCount: boardsProvider.boardsList.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(BoardDetail.routeName, arguments: boardsProvider.boardsList[index]);
          },
          child: Card(
            child: ListTile(
              leading:  boardsProvider.boardsList[index]!.image == ''
                  ? Image.network(
                      "https://i.ebayimg.com/images/g/am8AAOSw4m9b~Bks/s-l400.jpg")
                  : Image.network(boardsProvider.boardsList[index]!.image),
              title: Row(
                children: [
                  Text(
                     boardsProvider.boardsList[index]!.title,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.people),
                  Text(boardsProvider.boardsList[index]!.followers.toString()),
                ],
              ),
              subtitle: Text(
                 boardsProvider.boardsList[index]!.description,
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
