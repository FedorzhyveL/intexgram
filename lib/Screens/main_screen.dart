// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intexgram/Widgets/bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _dropDownValue = 'Intexgram';
  final _dropDownValues = ['Intexgram', 'Following', 'Favourites'];
  bool liked = false;
  int likes = 321;
  int bottomIndex = 0;

  Widget Post() {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/photos/original.jpg'),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Username'),
                    Text('Location'),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/photos/original.jpg',
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        liked = !liked;
                        liked == true ? likes++ : likes--;
                      });
                    },
                    icon: liked == true
                        ? Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_rounded,
                            color: Colors.grey,
                          ),
                  ),
                  IconButton(
                    icon: Icon(Icons.comment_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark_outline_rounded),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('${likes}likes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: DropdownButtonHideUnderline(
          child: DropdownButton(
            icon: Visibility(
              child: Icon(Icons.arrow_drop_down),
              //visible: false,
            ),
            value: _dropDownValue,
            items: _dropDownValues
                .map(
                  (String item) => DropdownMenuItem(
                    value: item,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value is String) {
                setState(() {
                  _dropDownValue = value;
                });
              }
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.mail_outline,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // STORIES
            Container(
              height: 85,
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 30,
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                radius: 29,
                                backgroundImage:
                                    AssetImage('assets/photos/original.jpg'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              'username',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                    ],
                  );
                },
              ),
            ),
            // Posts
            Post(),
            SizedBox(height: 10),
            Post(),
            SizedBox(height: 10),
            Post(),
            SizedBox(height: 10),
            Post(),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigatiom(2, context),
    );
  }
}
