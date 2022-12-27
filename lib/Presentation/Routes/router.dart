import 'package:auto_route/auto_route.dart';
import 'package:intexgram/Presentation/Screens/main_page/main_page.dart';
import 'package:intexgram/Presentation/Screens/main_screen/main_screen.dart';
import 'package:intexgram/Presentation/Screens/notifications_page.dart';
import 'package:intexgram/Presentation/Screens/profile_page.dart';
import 'package:intexgram/Presentation/Screens/search_page.dart';

import '../Screens/authorization/sign_in/sign_in.dart';
import '../Screens/authorization/sign_up/sign_up.dart';
import 'auth_guard.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      page: MainScreen,
      initial: true,
      guards: [AuthGuard],
      children: [
        AutoRoute(page: MainPage),
        AutoRoute(page: SearchPage),
        AutoRoute(page: MainPage),
        AutoRoute(page: NotificationsPage),
        AutoRoute(page: ProfilePage),
      ],
    ),
    AutoRoute(page: SignInPage),
    AutoRoute(page: SignUpPage),
  ],
)
class $FlutterRouter {}
