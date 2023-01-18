import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Domain/entities/comment_entity.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/extensions/date_time.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/comments_page/bloc/comments_page_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/comments_page_event.dart';
import 'bloc/comments_page_state.dart';

class CommentsPage extends StatefulWidget {
  final PostEntity post;
  const CommentsPage({
    super.key,
    required this.post,
  });

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController textEditingController = TextEditingController();
  late final CommentsPageBloc bloc;
  @override
  void initState() {
    bloc = CommentsPageBloc(
      serverLocator(),
      serverLocator(),
      serverLocator(),
      widget.post,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<CommentsPageBloc, CommentsPageState>(
        builder: (context, state) {
          return state.when(
            initial: ((post) {
              bloc.add(LoadDescription(post: post));
              return content(state);
            }),
            loaded: ((post, comments, currentUser, allowPublish) =>
                content(state)),
          );
        },
      ),
    );
  }

  Widget content(CommentsPageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            serverLocator<FlutterRouter>().pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Palette.appBarIconColor,
          ),
        ),
        title: const Text(
          "Comments",
          style: TextStyles.appBarText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: state is Loaded
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              comment(
                                state.comments[0],
                                state.currentUser,
                                state,
                              ),
                              const Divider(
                                height: 1,
                                color: Palette.profileUnselectedTabsColor,
                              ),
                            ],
                          );
                        } else {
                          return comment(
                            state.comments[index],
                            state.currentUser,
                            state,
                          );
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  SizedBox(
                    height: 80,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  state.currentUser.profilePicturePath),
                              radius: 30,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText:
                                    "Comment as\n${state.currentUser.nickName}",
                                border: InputBorder.none,
                              ),
                              onChanged: (value) => bloc.add(
                                CommentValueChanged(
                                  currentState: state,
                                  value: value,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              bloc.add(
                                AddComment(
                                  post: state.post,
                                  text: textEditingController.text,
                                ),
                              );
                              textEditingController.clear();
                              bloc.add(
                                CommentValueChanged(
                                  currentState: state,
                                  value: textEditingController.text,
                                ),
                              );
                              bloc.add(LoadDescription(post: state.post));
                            },
                            child: Text(
                              "Publish",
                              style: TextStyles.text.copyWith(
                                color: state.allowPublish == false
                                    ? Palette.disabledButtonColor
                                    : Palette.abledButtonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget comment(
    CommentEntity comment,
    PersonEntity currentUser,
    CommentsPageState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(comment.user.profilePicturePath),
              radius: 30,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (state.post.owner.email != currentUser.email) {
                          serverLocator<FlutterRouter>().push(
                            ProfilePageRoute(
                              userEmail: state.post.owner.email,
                            ),
                          );
                        } else {
                          serverLocator<FlutterRouter>().navigate(
                            MainScreenRoute(
                              children: [
                                ProfilePageRoute(
                                    userEmail: state.post.owner.email)
                              ],
                            ),
                          );
                        }
                      },
                      child: Text(
                        comment.user.nickName,
                        style: TextStyles.text.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      comment.creationTime.date,
                      style: TextStyles.text.copyWith(
                        color: Palette.notLikedPostLikeColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Text(
                  comment.text,
                  style: TextStyles.text.copyWith(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
