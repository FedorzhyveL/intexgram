import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
              bottom: 10,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.search),
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Search'),
                ),
              ),
            ),
          ),
          //gallery(),
        ],
      ),
    );
  }

  Widget gallery() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/photos/original.jpg'),
        ),
      ],
    );
  }
}
