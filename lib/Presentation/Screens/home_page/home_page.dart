import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/home_page/bloc/home_page_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/post.dart';
import 'package:intexgram/Presentation/Screens/widgets/stories.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/home_page_event.dart';
import 'bloc/home_page_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _dropDownValue = 'Intexgram';

  final _dropDownValues = ['Intexgram', 'Following', 'Favourites'];

  late final HomePageBloc bloc;

  @override
  void initState() {
    bloc = HomePageBloc(
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(const LoadUser()),
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is Updated) bloc.add(Update(state.posts, state.following));
          if (state is Ready) bloc.add(LoadGallery(state.user));
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Palette.appBarColor,
              title: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: const Visibility(
                    //visible: false,
                    child: Icon(Icons.arrow_drop_down),
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
                              style: TextStyles.appBarText.copyWith(
                                fontSize: 20,
                              ),
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
                    color: Palette.appBarIconColor,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    serverLocator<FlutterRouter>()
                        .replace(const SignInPageRoute());
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
                onRefresh: () {
                  final refreshBloc = bloc.stream.first;
                  bloc.add(const LoadUser());
                  return refreshBloc;
                },
                child: mainPageBody(state)),
          );
        },
      ),
    );
  }

  Widget mainPageBody(HomePageState state) {
    if (state is Ready || state is GalleryReady) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STORIES
            Container(
              height: 85,
              margin: const EdgeInsets.only(top: 10, left: 2.5, right: 2.5),
              child: state is Ready
                  ? Stories(
                      imagePath: state.user.profilePicturePath,
                      nickName: "your stories",
                      onTap: () {},
                    )
                  : state is GalleryReady
                      ? ListView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: state.following.length,
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Stories(
                              imagePath:
                                  state.following[index].profilePicturePath,
                              nickName: index == 0
                                  ? "your stories"
                                  : state.following[index].nickName,
                              onTap: () {
                                if (index != 0) {
                                  serverLocator<FlutterRouter>().push(
                                    ProfilePageRoute(
                                      userEmail: state.following[index].email,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        )
                      : Container(),
            ),
            const Divider(
              height: 1,
              color: Palette.profileUnselectedTabsColor,
            ),
            //Gallery
            state is GalleryReady
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      return Post(
                        post: state.posts[index],
                        addToFavorite: () {
                          bloc.add(
                            AddToFavorite(
                              state.posts,
                              state.posts[index],
                              index,
                              state.following,
                            ),
                          );
                        },
                        removeFromFavorite: () {
                          bloc.add(
                            RemoveFromFavorite(
                              state.posts,
                              state.posts[index],
                              index,
                              state.following,
                            ),
                          );
                        },
                        removeLike: () {
                          bloc.add(
                            RemoveLike(
                              state.posts,
                              state.posts[index],
                              index,
                              state.following,
                            ),
                          );
                        },
                        setLike: () {
                          bloc.add(
                            SetLike(
                              state.posts,
                              state.posts[index],
                              index,
                              state.following,
                            ),
                          );
                        },
                      );
                    },
                  )
                : Container(),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
