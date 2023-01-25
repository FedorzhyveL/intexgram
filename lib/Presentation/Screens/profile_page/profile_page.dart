import 'package:cached_network_image/cached_network_image.dart';
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
      child: BlocConsumer<ProfilePageBloc, ProfilePageState>(
        listener: (context, state) {
          if (state is Ready) {
            if (state.posts.length != state.user.posts) {
              bloc.add(LoadMore(state));
            }
          }
        },
        builder: (context, state) {
          return state.when(
            initial: (userEmail) => profilePage(state),
            ready: (user, currentUserEmail, posts, isFollowing) =>
                profilePage(state),
            loading: (user, currentUserEmail, posts, isFollowing) =>
                profilePage(state),
          );
        },
      ),
    );
  }

  Widget profilePage(
    ProfilePageState state,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        leading: state.when(
          initial: (userEmail) => null,
          ready: (user, currentUserEmail, posts, isFollowing) =>
              _leadingIcon(user.email, currentUserEmail),
          loading: (user, currentUserEmail, posts, isFollowing) =>
              _leadingIcon(user.email, currentUserEmail),
        ),
        titleSpacing: 0,
        title: ListTile(
          title: Text(
            state.when(
                initial: (userEmail) => "nick name",
                ready: (user, currentUserEmail, posts, isFollowing) =>
                    user.nickName,
                loading: (user, currentUserEmail, posts, isFollowing) =>
                    user.nickName),
            style: TextStyles.appBarText.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: state.when(
                initial: (userEmail) => [
                  Container(
                    width: 35,
                    height: 35,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 35,
                    height: 35,
                    color: Colors.grey,
                  ),
                ],
                ready: (user, currentUserEmail, posts, isFollowing) =>
                    actions(user.email, currentUserEmail),
                loading: (user, currentUserEmail, posts, isFollowing) =>
                    actions(user.email, currentUserEmail),
              ),
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
                    profileHeaderWidget(state),
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
                  children: state.when(
                    initial: (userEmail) => [
                      Container(),
                      Container(),
                    ],
                    ready: (user, currentUserEmail, posts, isFollowing) => [
                      gallery(state, user),
                      gallery(state, user),
                    ],
                    loading: (user, currentUserEmail, posts, isFollowing) => [
                      gallery(state, user),
                      gallery(state, user),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> actions(String userEmail, String currentUserEmail) {
    return userEmail == currentUserEmail
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
          ];
  }

  IconButton? _leadingIcon(String userEmail, String currentUserEmail) {
    return userEmail != currentUserEmail
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
        : null;
  }

  Widget profileHeaderWidget(
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
                    backgroundColor: Colors.transparent,
                    backgroundImage: state.when(
                      initial: (userEmail) => const AssetImage(
                          'assets/photos/default_profile_image.png'),
                      ready: (user, currentUserEmail, posts, isFollowing) =>
                          CachedNetworkImageProvider(user.profilePicturePath),
                      loading: (user, currentUserEmail, posts, isFollowing) =>
                          CachedNetworkImageProvider(user.profilePicturePath),
                    ),
                  ),
                  profileData(state),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                state.when(
                  initial: (userEmail) => "user name",
                  ready: (user, currentUserEmail, posts, isFollowing) =>
                      user.userName,
                  loading: (user, currentUserEmail, posts, isFollowing) =>
                      user.userName,
                ),
                style: TextStyles.text.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Visibility(
              visible: state.when(
                initial: (userEmail) => false,
                ready: (user, currentUserEmail, posts, isFollowing) =>
                    user.description == '' ? false : true,
                loading: (user, currentUserEmail, posts, isFollowing) =>
                    user.description == '' ? false : true,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  state.when(
                    initial: (userEmail) => '',
                    ready: (user, currentUserEmail, posts, isFollowing) =>
                        user.description == null ? '' : user.description!,
                    loading: (user, currentUserEmail, posts, isFollowing) =>
                        user.description == null ? '' : user.description!,
                  ),
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
                    isVisible: state.when(
                      initial: (userEmail) => false,
                      ready: (user, currentUserEmail, posts, isFollowing) =>
                          user.email == currentUserEmail ? true : false,
                      loading: (user, currentUserEmail, posts, isFollowing) =>
                          user.email == currentUserEmail ? true : false,
                    ),
                    onPressed: () async {
                      state.when(
                        initial: (userEmail) {},
                        ready: (user, currentUserEmail, posts,
                                isFollowing) async =>
                            await editProfileButtonAction(state, user),
                        loading: (user, currentUserEmail, posts,
                                isFollowing) async =>
                            await editProfileButtonAction(state, user),
                      );
                    },
                    label: 'Edit profile',
                    backgroundColor: Palette.profileButtonDefautColor,
                    foregroundColor: Palette.textColor,
                  ),
                  ProfileButton(
                    isVisible: state.when(
                      initial: (userEmail) => false,
                      ready: (user, currentUserEmail, posts, isFollowing) =>
                          user.email == currentUserEmail ? false : true,
                      loading: (user, currentUserEmail, posts, isFollowing) =>
                          user.email == currentUserEmail ? false : true,
                    ),
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
                          : state is Ready
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
                              : null;
                    },
                    label: state is Ready
                        ? state.isFollowing == true
                            ? 'Unsubscribe'
                            : 'Subscribe'
                        : state is Ready
                            ? state.isFollowing == true
                                ? 'Unsubscribe'
                                : 'Subscribe'
                            : '',
                    backgroundColor: state is Ready
                        ? state.isFollowing == true
                            ? Palette.profileButtonDefautColor
                            : Palette.profileButtonSecondColor
                        : state is Ready
                            ? state.isFollowing == true
                                ? Palette.profileButtonDefautColor
                                : Palette.profileButtonSecondColor
                            : Palette.profileButtonDefautColor,
                    foregroundColor: state is Ready
                        ? state.isFollowing == true
                            ? Palette.textColor
                            : Palette.profileButtonDefautColor
                        : state is Ready
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

  Future<void> editProfileButtonAction(
    ProfilePageState state,
    PersonEntity user,
  ) async {
    var isChanged = await serverLocator<FlutterRouter>().push(
      ProfileInformationRoute(user: user),
    );
    if (isChanged == true) {
      bloc.add(Load(state));
    }
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
              : state is Ready
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
                : state is Ready
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
                : state is Ready
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
          bloc.add(Load(state));
          return refreshBloc;
        },
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 2.5,
                mainAxisSpacing: 2.5,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: state.posts.length,
                (context, index) {
                  return GestureDetector(
                    child: FittedBox(
                      clipBehavior: Clip.hardEdge,
                      fit: BoxFit.cover,
                      child: Image(
                        image: CachedNetworkImageProvider(
                            state.posts[index].imagePath),
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
            ),
            if (state.posts.isEmpty && state.user.posts != 0)
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 2.5,
                  mainAxisSpacing: 2.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 15,
                  (context, index) {
                    return FittedBox(
                      clipBehavior: Clip.hardEdge,
                      fit: BoxFit.cover,
                      child: AnimatedContainer(
                        width: 200,
                        height: 200,
                        color: Colors.grey[300],
                        duration: const Duration(seconds: 1),
                        curve: Curves.linear,
                      ),
                    );
                  },
                ),
              ),
            if (state.posts.length != state.user.posts &&
                state.posts.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
          ],
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
