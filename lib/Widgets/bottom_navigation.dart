import 'package:flutter/material.dart';
import 'package:intexgram/Screens/profile.dart';

Widget MyBottomNavigatiom(int bottomIndex, BuildContext context) {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home_filled,
          color: Colors.black,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.search_outlined,
          color: Colors.black,
        ),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.add_box_outlined,
          color: Colors.black,
        ),
        label: 'New post',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite_border_rounded,
          color: Colors.black,
        ),
        label: 'Actions',
      ),
      BottomNavigationBarItem(
        icon: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 17,
          child: CircleAvatar(
            radius: 120,
            backgroundImage: AssetImage('assets/photos/original.jpg'),
          ),
        ),
        label: 'Profile',
      ),
    ],
    currentIndex: bottomIndex,
    onTap: (value) {
      if (value == 4) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const ProfilePage();
            },
          ),
        );
      }
    },
  );
}
