import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset('assets/photos/original.jpg'),
          ),
        ],
      ),
    );
  }
}
