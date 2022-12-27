import 'package:auto_route/auto_route.dart';
import 'package:intexgram/Presentation/Screens/main_screen/main_screen.dart';
import 'package:intexgram/Presentation/Screens/pages/pages/search_page.dart';

import '../Screens/authorization/sign_in/screen/sign_in.dart';
import '../Screens/authorization/sign_up/screens/sign_up.dart';
import '../Screens/pages/pages/main_page.dart';
import '../Screens/pages/pages/notifications_page.dart';
import '../Screens/pages/pages/profile_page.dart';
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
