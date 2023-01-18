import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/extensions/date_time.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

class Post extends StatelessWidget {
  final PostEntity post;
  final Function setLike;
  final Function removeLike;
  final Function addToFavorite;
  final Function removeFromFavorite;

  const Post({
    super.key,
    required this.post,
    required this.setLike,
    required this.removeLike,
    required this.addToFavorite,
    required this.removeFromFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    CachedNetworkImageProvider(post.owner.profilePicturePath),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.owner.nickName,
                      style: TextStyles.text.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Image(
          width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .size
              .width
              .toDouble(),
          image: CachedNetworkImageProvider(post.imagePath),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: Row(
            children: [
              IconButton(
                iconSize: 35,
                splashRadius: 0.1,
                onPressed: () async {
                  post.isLiked == true ? await removeLike() : await setLike();
                },
                icon: post.isLiked
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: Palette.likedPostLikeColor,
                      )
                    : const Icon(
                        Icons.favorite_rounded,
                        color: Palette.notLikedPostLikeColor,
                      ),
              ),
              IconButton(
                iconSize: 35,
                splashRadius: 0.1,
                icon: const Icon(Icons.comment_outlined),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 35,
                splashRadius: 0.1,
                icon: post.isFavorite
                    ? const Icon(
                        Icons.bookmark_rounded,
                        color: Palette.postFavoriteColor,
                      )
                    : const Icon(
                        Icons.bookmark_outline_rounded,
                        color: Palette.postFavoriteColor,
                      ),
                onPressed: () async {
                  post.isFavorite
                      ? await removeFromFavorite()
                      : await addToFavorite();
                },
              ),
            ],
          ),
        ),
        if (post.likes != 0)
          GestureDetector(
            onTap: () {
              serverLocator<FlutterRouter>().push(
                ListOfUsersRoute(
                  docId: post.id,
                  appBarLabel: "Likes",
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Likes: ${post.likes}",
                  style: TextStyles.text.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 5,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (post.owner.email !=
                        FirebaseAuth.instance.currentUser!.email) {
                      serverLocator<FlutterRouter>().push(
                        ProfilePageRoute(
                          userEmail: post.owner.email,
                        ),
                      );
                    } else {
                      serverLocator<FlutterRouter>().navigate(
                        MainScreenRoute(
                          children: [
                            ProfilePageRoute(userEmail: post.owner.email)
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(
                    "${post.owner.nickName} ",
                    style: TextStyles.text.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    serverLocator<FlutterRouter>().push(
                      CommentsPageRoute(
                        post: post,
                      ),
                    );
                  },
                  child: Text(
                    post.description!,
                    style: TextStyles.text.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 5,
            bottom: 10,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post.creationTime.date,
              style: TextStyles.text.copyWith(
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
