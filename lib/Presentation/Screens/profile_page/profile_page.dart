import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/profile_page/bloc/profile_page_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/profile_button_widget.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/profile_page_event.dart';
import 'bloc/profile_page_state.dart';

class ProfilePage extends StatefulWidget {
  final String userEmail;
  const ProfilePage({
    super.key,
    required this.userEmail,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late final ProfilePageBloc bloc;

  @override
  void initState() {
    bloc = ProfilePageBloc(
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      widget.userEmail,
    );
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
        builder: (context, state) {
          if (state is Initial) bloc.add(GetUser(state.userEmail));
          if (state is UserReady) {
            bloc.add(
              LoadGallery(
                state.user,
                state.isFollowing,
              ),
            );

            return profilePage(state.user, state);
          } else {
            if (state is Ready) {
              return profilePage(state.user, state);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  Widget profilePage(
    PersonEntity user,
    ProfilePageState state,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        leading: user.email != FirebaseAuth.instance.currentUser!.email
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
                ),
                color: Palette.appBarIconColor,
                onPressed: () {
                  serverLocator<FlutterRouter>().pop();
                },
              )
            : null,
        titleSpacing: 0,
        title: ListTile(
          title: Text(
            user.nickName.toString(),
            style: TextStyles.appBarText.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: user.email == FirebaseAuth.instance.currentUser!.email
                  ? [
                      IconButton(
                        icon: const Icon(
                          Icons.add_box_outlined,
                          size: 35,
                        ),
                        color: Palette.appBarIconColor,
                        onPressed: () {},
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu_rounded,
                          size: 35,
                        ),
                        color: Palette.appBarIconColor,
                      ),
                    ]
                  : [
                      IconButton(
                        icon: const Icon(Icons.notifications_none_rounded),
                        color: Palette.appBarIconColor,
                        onPressed: () {},
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                        color: Palette.appBarIconColor,
                      ),
                    ],
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    profileHeaderWidget(user, state),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: Palette.profileUnselectedTabsColor),
                  ),
                ),
                child: TabBar(
                  indicatorColor: Palette.profileTabsIconColor,
                  controller: tabController,
                  tabs: const [
                    Tab(
                      icon: Icon(
                        Icons.grid_on_sharp,
                        color: Palette.profileTabsIconColor,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.supervised_user_circle_outlined,
                        color: Palette.profileTabsIconColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2.5),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    gallery(state, user),
                    gallery(state, user),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileHeaderWidget(
    PersonEntity user,
    ProfilePageState state,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        CachedNetworkImageProvider(user.profilePicturePath),
                  ),
                  profileData(state),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                user.userName.toString(),
                style: TextStyles.text.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Visibility(
              visible: user.description == '' ? false : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  user.description == null ? '' : user.description!,
                  style: TextStyles.text.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileButton(
                    isVisible:
                        user.email == FirebaseAuth.instance.currentUser!.email
                            ? true
                            : false,
                    onPressed: () async {
                      var isChanged = await serverLocator<FlutterRouter>().push(
                        ProfileInformationRoute(user: user),
                      );
                      if (isChanged == true) {
                        bloc.add(GetUser(user.email));
                      }
                    },
                    label: 'Edit profile',
                    backgroundColor: Palette.profileButtonDefautColor,
                    foregroundColor: Palette.textColor,
                  ),
                  ProfileButton(
                    isVisible:
                        user.email == FirebaseAuth.instance.currentUser!.email
                            ? false
                            : true,
                    onPressed: () {
                      state is Ready
                          ? state.isFollowing == true
                              ? bloc.add(
                                  UnSubscribe(
                                    state.user,
                                    state.currentUserEmail,
                                    state.posts,
                                    state.isFollowing,
                                  ),
                                )
                              : bloc.add(
                                  Subscribe(
                                    state.user,
                                    state.currentUserEmail,
                                    state.posts,
                                    state.isFollowing,
                                  ),
                                )
                          : state is UserReady
                              ? state.isFollowing == true
                                  ? bloc.add(
                                      UnSubscribe(
                                        state.user,
                                        state.currentUserEmail,
                                        null,
                                        state.isFollowing,
                                      ),
                                    )
                                  : bloc.add(
                                      Subscribe(
                                        state.user,
                                        state.currentUserEmail,
                                        null,
                                        state.isFollowing,
                                      ),
                                    )
                              : null;
                    },
                    label: state is Ready
                        ? state.isFollowing == true
                            ? 'Unsubscribe'
                            : 'Subscribe'
                        : state is UserReady
                            ? state.isFollowing == true
                                ? 'Unsubscribe'
                                : 'Subscribe'
                            : '',
                    backgroundColor: state is Ready
                        ? state.isFollowing == true
                            ? Palette.profileButtonDefautColor
                            : Palette.profileButtonSecondColor
                        : state is UserReady
                            ? state.isFollowing == true
                                ? Palette.profileButtonDefautColor
                                : Palette.profileButtonSecondColor
                            : Palette.profileButtonDefautColor,
                    foregroundColor: state is Ready
                        ? state.isFollowing == true
                            ? Palette.textColor
                            : Palette.profileButtonDefautColor
                        : state is UserReady
                            ? state.isFollowing == true
                                ? Palette.textColor
                                : Palette.profileButtonDefautColor
                            : Palette.textColor,
                  ),
                ],
              ),
            ),
            hilitedStories(),
          ],
        ),
      ),
    );
  }

  Widget hilitedStories() {
    return Visibility(
      visible: false,
      child: Container(
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
                        'user.nickName.toString()',
                        style: TextStyle(fontSize: 10),
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
    );
  }

  Widget profileData(ProfilePageState state) {
    return Row(
      children: [
        dataColumn(
          "Posts",
          state is Ready
              ? state.user.posts
              : state is UserReady
                  ? state.user.posts
                  : null,
        ),
        const SizedBox(width: 30),
        GestureDetector(
          onTap: () {
            serverLocator<FlutterRouter>().push(
              ListOfUsersRoute(
                docId: widget.userEmail,
                appBarLabel: "Followers",
              ),
            );
          },
          child: dataColumn(
            "Followers",
            state is Ready
                ? state.user.followers
                : state is UserReady
                    ? state.user.followers
                    : null,
          ),
        ),
        const SizedBox(width: 30),
        GestureDetector(
          onTap: () {
            serverLocator<FlutterRouter>().push(
              ListOfUsersRoute(
                docId: widget.userEmail,
                appBarLabel: "Following",
              ),
            );
          },
          child: dataColumn(
            "Following",
            state is Ready
                ? state.user.following
                : state is UserReady
                    ? state.user.following
                    : null,
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  Widget gallery(
    ProfilePageState state,
    PersonEntity user,
  ) {
    if (state is Ready) {
      return RefreshIndicator(
        onRefresh: () {
          Future refreshBloc = bloc.stream.first;
          bloc.add(
            LoadGallery(
              state.user,
              state.isFollowing,
            ),
          );
          return refreshBloc;
        },
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 2.5,
            mainAxisSpacing: 2.5,
          ),
          itemCount: state.user.posts,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: FittedBox(
                clipBehavior: Clip.hardEdge,
                fit: BoxFit.cover,
                child: Image(
                  image:
                      CachedNetworkImageProvider(state.posts[index].imagePath),
                ),
              ),
              onTap: () {
                serverLocator<FlutterRouter>().push(
                  UserListOfPostsRoute(
                    posts: state.posts,
                    position: index.toDouble(),
                  ),
                );
              },
            );
          },
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget dataColumn(String label, int? number) {
    return Column(
      children: [
        number == null
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              )
            : Text(
                number.toString(),
                style: TextStyles.text.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
        Text(
          label,
          style: TextStyles.text.copyWith(
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
