import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/pages/boards/board_detail.dart';
import 'package:trendmate/providers/boards_provider.dart';

class BoardsPage extends StatefulWidget {
  static const routeName = '/boards-page';
  const BoardsPage({Key? key}) : super(key: key);

  @override
  State<BoardsPage> createState() => _BoardsPageState();
}

class _BoardsPageState extends State<BoardsPage> {
  final titleController = TextEditingController();

  void editBoard(String boardId) {
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
                        "New Title",
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
                                    boardsprovider.editBoardName(
                                        boardId, titleController.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Save"));
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

  @override
  Widget build(BuildContext context) {
    final boardsProvider = Provider.of<BoardsProvider>(context);
    if (boardsProvider.boardsList.isEmpty) {
      return Center(
        child: Text("No boards to show!"),
      );
    } else {
      return ListView.builder(
        itemCount: boardsProvider.boardsList.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(BoardDetail.routeName, arguments: index);
          },
          child: Card(
            child: ListTile(
              leading: boardsProvider.boardsList[index].image == ''
                  ? Image.network(
                      "https://i.ebayimg.com/images/g/am8AAOSw4m9b~Bks/s-l400.jpg")
                  : Image.network(boardsProvider.boardsList[index].image),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    boardsProvider.boardsList[index].title,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.people),
                  Text(boardsProvider.boardsList[index].followers.toString()),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      editBoard(boardsProvider.boardsList[index].boardId);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.orange,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      boardsProvider.deleteBoard(
                          boardsProvider.boardsList[index].boardId);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
