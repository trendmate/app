import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/providers/social_provider.dart';

class SocialSearch extends StatefulWidget {
  SocialSearch({Key? key}) : super(key: key);

  @override
  _SocialSearchState createState() => _SocialSearchState();
}

class _SocialSearchState extends State<SocialSearch> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SocialProvider>(
      builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(32, 8, 8, 8),
              child: TextFormField(
                autofocus: true,
                onChanged: (value) => provider.setSearchText(value),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: "Search"),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Text("People"),
                Expanded(
                  child: ListView(
                    children: provider.searchedUsers
                        .map((e) => Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Column(
                                children: [
                                  Text(e.name),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        provider.followUser(e);
                                      },
                                      child: Text(
                                          provider.user!.friends.contains(e.uid)
                                              ? "Unfollow"
                                              : "Follow"))
                                ],
                              )),
                            )))
                        .toList(),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Text("Boards"),
                Expanded(
                  child: ListView(
                    children: provider.searchingBoards
                        .map((e) => Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(e.title),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          provider.followBoard(e);
                                        },
                                        child: Text(provider
                                                .user!.followed_boards
                                                .contains(e.boardId)
                                            ? "Unfollow"
                                            : "Follow"))
                                  ],
                                ),
                              ),
                            )))
                        .toList(),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
