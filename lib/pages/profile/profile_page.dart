import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trendmate/models/social/board.dart';
import 'package:trendmate/models/user.dart';

import 'package:trendmate/providers/user_provider.dart';
import 'package:trendmate/providers/boards_provider.dart';
import 'package:trendmate/services/firebase_methods.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "profile-page";
  const ProfilePage({
    Key? key,
    this.user,
  }) : super(key: key);

  final User? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();

  void editName() {
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
                        "Change Name",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(hintText: 'Name'),
                      ),
                      Row(
                        children: [
                          Consumer<BoardsProvider>(
                            builder: (BuildContext context, boardsprovider,
                                Widget? child) {
                              return TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Change"));
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

  void out() {
    auth.FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (BuildContext context, userProvider, Widget? child) {
      String image =
          widget.user == null ? userProvider.user!.image : widget.user!.image;
      String name =
          widget.user == null ? userProvider.user!.name : widget.user!.name;

      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          border:
                              Border.all(color: Colors.grey[500]!, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(
                          Icons.person_outline_rounded,
                          color: Colors.grey[850],
                          size: 120,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 20),
                        ),
                        if (widget.user == null ||
                            UserProvider.instance.user!.uid
                                    .compareTo(widget.user!.uid) ==
                                0)
                          IconButton(
                              onPressed: editName, icon: Icon(Icons.edit)),
                        ElevatedButton(
                            onPressed: () {
                              out();
                            },
                            child: Text('Logout'))
                      ]),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Stack(alignment: Alignment(0, 0.5), children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.cyan[800],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
              if (widget.user == null)
                Consumer<BoardsProvider>(builder:
                    (BuildContext context, boardsprovider, Widget? child) {
                  return BoardsDisplay(boardsList: boardsprovider.boardsList);
                }),
              if (widget.user != null)
                FutureBuilder(
                    future: FirebaseMethods.instance
                        .getBaords(widget.user!.my_boards),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return BoardsDisplay(boardsList: []);
                      } else {
                        return BoardsDisplay(
                            boardsList: snapshot.data as List<Board>);
                      }
                    })
            ])
          ],
        ),
      );
    });
  }
}

class BoardsDisplay extends StatefulWidget {
  const BoardsDisplay({
    Key? key,
    required this.boardsList,
  }) : super(key: key);

  final List<Board> boardsList;

  @override
  State<BoardsDisplay> createState() => _BoardsDisplayState();
}

class _BoardsDisplayState extends State<BoardsDisplay> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: widget.boardsList.isEmpty
            ? Text(
                "No boards created yet...",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            : SizedBox(
                height: 200, // card height
                child: PageView.builder(
                    itemCount: widget.boardsList.length,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      String image = widget.boardsList[i].image;
                      String name = widget.boardsList[i].title;

                      return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              image == ''
                                  ? Expanded(
                                      child: Image.network(
                                          "https://i.ebayimg.com/images/g/am8AAOSw4m9b~Bks/s-l400.jpg"),
                                    )
                                  : Expanded(child: Image.network(image)),
                              Text(
                                name,
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      );
                    })));
  }
}
