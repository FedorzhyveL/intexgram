import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/main_page/cubit/pages_cubit.dart';
import 'package:intexgram/locator_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String _dropDownValue = 'Intexgram';

  final _dropDownValues = ['Intexgram', 'Following', 'Favourites'];

  late final PagesCubit cubit;

  @override
  void initState() {
    cubit = PagesCubit(serverLocator());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getUser(),
      child: BlocBuilder<PagesCubit, PagesState>(
        builder: (context, state) {
          if (state is PageReady) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white70,
                title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: const Visibility(
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
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      if (value is String) {}
                    },
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.mail_outline,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      serverLocator<FlutterRouter>()
                          .replace(const SignInPageRoute());
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // STORIES
                    Container(
                      height: 85,
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30,
                                    child: Padding(
                                      padding: EdgeInsets.all(2),
                                      child: CircleAvatar(
                                        radius: 29,
                                        backgroundImage: AssetImage(
                                            'assets/photos/original.jpg'),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      state.user.nickName.toString(),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5),
                            ],
                          );
                        },
                      ),
                    ),
                    // Posts
                    post(),
                    post(),
                    post(),
                    post(),
                  ],
                ),
              ),
              // bottomNavigationBar: myBottomNavigation(0, context),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget post() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/photos/original.jpg'),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('user.userName!'),
                Text('Location'),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Image.asset(
          'assets/photos/original.jpg',
          width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .size
              .width
              .toDouble(),
          //width: 200,
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // setState(() {
                  //   liked = !liked;
                  //   liked == true ? likes++ : likes--;
                  // });
                },
                // icon: liked == true
                //     ? const Icon(
                //         Icons.favorite_rounded,
                //         color: Colors.red,
                //       )
                //     : const Icon(
                //         Icons.favorite_rounded,
                //         color: Colors.grey,
                //       ),
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.comment_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_outline_rounded),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('{likes}likes'),
          ),
        ),
      ],
    );
  }
}
