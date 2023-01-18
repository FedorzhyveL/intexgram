import 'package:auto_route/auto_route.dart';
import 'package:intexgram/Presentation/Screens/add_photo_screen/add_photo_page.dart';
import 'package:intexgram/Presentation/Screens/add_post_page/add_post_page.dart';
import 'package:intexgram/Presentation/Screens/authorization/sign_in/sign_in.dart';
import 'package:intexgram/Presentation/Screens/authorization/sign_up/sign_up.dart';
import 'package:intexgram/Presentation/Screens/comments_page/comments_page.dart';
import 'package:intexgram/Presentation/Screens/home_page/home_page.dart';
import 'package:intexgram/Presentation/Screens/list_of_users/list_of_users.dart';
import 'package:intexgram/Presentation/Screens/main_screen/main_screen.dart';
import 'package:intexgram/Presentation/Screens/favorites_screen/favorites_page.dart';
import 'package:intexgram/Presentation/Screens/profile_information/profile_information.dart';
import 'package:intexgram/Presentation/Screens/profile_page/profile_page.dart';
import 'package:intexgram/Presentation/Screens/search_screen/search_page.dart';
import 'package:intexgram/Presentation/Screens/user_list_of_posts/user_list_of_posts.dart';

import 'auth_guard.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      page: MainScreen,
      initial: true,
      guards: [AuthGuard],
      children: [
        AutoRoute(page: HomePage),
        AutoRoute(page: SearchPage),
        AutoRoute(page: AddPhoto),
        AutoRoute(page: FavoritesPage),
        CustomRoute(
          page: ProfilePage,
          path: 'profile-page',
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
      ],
    ),
    CustomRoute(
      page: ProfilePage,
      path: 'profile-page',
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    AutoRoute(page: SignInPage),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: AddPostPage),
    AutoRoute<bool>(page: ProfileInformation),
    AutoRoute(page: UserListOfPosts),
    AutoRoute(page: ListOfUsers),
    AutoRoute(page: CommentsPage),
  ],
)
class $FlutterRouter {}
