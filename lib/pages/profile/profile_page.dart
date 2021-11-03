import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:trendmate/providers/user_provider.dart';
import 'package:trendmate/providers/boards_provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "profile-page";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _index = 0;

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

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (BuildContext context, userProvider, Widget? child) {
      String image = userProvider.user!.image;
      String name = userProvider.user!.name;

      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      border: Border.all(color: Colors.grey[500]!, width: 1),
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
                    IconButton(onPressed: editName, icon: Icon(Icons.edit))
                  ]),
                )
              ],
            ),
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
              Consumer<BoardsProvider>(builder:
                  (BuildContext context, boardsprovider, Widget? child) {
                return Center(
                    child: boardsprovider.boardsList.isEmpty
                        ? Text(
                            "No boards created yet...",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : SizedBox(
                            height: 200, // card height
                            child: PageView.builder(
                                itemCount: boardsprovider.boardsList.length,
                                controller:
                                    PageController(viewportFraction: 0.7),
                                onPageChanged: (int index) =>
                                    setState(() => _index = index),
                                itemBuilder: (_, i) {
                                  String image =
                                      boardsprovider.boardsList[i].image;
                                  String name =
                                      boardsprovider.boardsList[i].title;

                                  return Transform.scale(
                                    scale: i == _index ? 1 : 0.9,
                                    child: Card(
                                      elevation: 6,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          image == ''
                                              ? Expanded(
                                                  child: Image.network(
                                                      "https://i.ebayimg.com/images/g/am8AAOSw4m9b~Bks/s-l400.jpg"),
                                                )
                                              : Expanded(
                                                  child: Image.network(image)),
                                          Text(
                                            name,
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })));
              }),
            ])
          ],
        ),
      );
    });
  }
}
