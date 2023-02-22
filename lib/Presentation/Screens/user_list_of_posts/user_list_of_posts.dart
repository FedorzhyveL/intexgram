import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/user_list_of_posts/bloc/user_list_of_posts_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/post.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/user_list_of_posts_event.dart';
import 'bloc/user_list_of_posts_state.dart';

class UserListOfPosts extends StatefulWidget {
  final List<PostEntity> posts;
  final double position;

  const UserListOfPosts({
    super.key,
    required this.posts,
    required this.position,
  });

  @override
  State<UserListOfPosts> createState() => _UserListOfPostsState();
}

class _UserListOfPostsState extends State<UserListOfPosts> {
  ScrollController scrollController = ScrollController();

  late final UserListOfPostsBloc bloc;

  @override
  void initState() {
    bloc = UserListOfPostsBloc(
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      widget.posts,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<UserListOfPostsBloc, UserListOfPostsState>(
        builder: (context, state) {
          return state.when(
            initial: (posts) => content(posts),
            postUpdated: (posts) {
              bloc.add(SetToInitial(state.posts));
              return content(posts);
            },
          );
        },
      ),
    );
  }

  Widget content(List<PostEntity> posts) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Palette.appBarColor,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                  ),
                  color: Palette.appBarIconColor,
                  onPressed: () {
                    serverLocator<FlutterRouter>().pop();
                  },
                ),
                title: const Text(
                  "Posts",
                  style: TextStyles.appBarText,
                ),
              ),
            ];
          },
          body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Post(
                post: posts[index],
                addToFavorite: () {
                  bloc.add(
                    AddPostToFavorite(
                      posts,
                      posts[index],
                      index,
                    ),
                  );
                },
                removeFromFavorite: () {
                  bloc.add(
                    RemovePostFromFavorite(
                      posts,
                      posts[index],
                      index,
                    ),
                  );
                },
                removeLike: () {
                  bloc.add(
                    RemoveLike(
                      posts,
                      posts[index],
                      index,
                    ),
                  );
                },
                setLike: () {
                  bloc.add(
                    SetLike(
                      posts,
                      posts[index],
                      index,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
