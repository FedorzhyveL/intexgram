import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/search_screen/bloc/search_page_bloc.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/search_page_event.dart';
import 'bloc/search_page_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  late final SearchPageBloc bloc;
  @override
  void initState() {
    bloc = SearchPageBloc(serverLocator());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(const GetAllUsers()),
      child: BlocBuilder<SearchPageBloc, SearchPageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: searchPageAppBar(state),
            body: searchPageBody(state),
          );
        },
      ),
    );
  }

  AppBar searchPageAppBar(SearchPageState state) {
    return AppBar(
      backgroundColor: Palette.appBarColor,
      title: GestureDetector(
        child: Expanded(
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Palette.appBarIconColor,
              ),
              Flexible(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search',
                  ),
                  style: TextStyles.text.copyWith(
                    fontSize: 15,
                  ),
                  controller: searchController,
                  onChanged: (value) {
                    if (state is Loaded) {
                      bloc.add(UpdateList(state.users));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget searchPageBody(SearchPageState state) {
    if (state is Loaded) {
      return Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.users.length,
            itemBuilder: (BuildContext context, int index) {
              if (state.users[index].nickName.contains(searchController.text) ||
                  state.users[index].userName.contains(searchController.text)) {
                return GestureDetector(
                  onTap: () {
                    serverLocator<FlutterRouter>().push(
                      ProfilePageRoute(
                        userEmail: state.users[index].email,
                      ),
                    );
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 25,
                          right: 25,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                state.users[index].profilePicturePath,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.users[index].nickName,
                                  style: TextStyles.text,
                                ),
                                Text(
                                  state.users[index].userName,
                                  style: TextStyles.text.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
