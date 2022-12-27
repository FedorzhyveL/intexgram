// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:intexgram/Presentation/Routes/auth_guard.dart' as _i10;
import 'package:intexgram/Presentation/Screens/authorization/sign_in/sign_in.dart'
    as _i2;
import 'package:intexgram/Presentation/Screens/authorization/sign_up/sign_up.dart'
    as _i3;
import 'package:intexgram/Presentation/Screens/main_screen/main_screen.dart'
    as _i1;
import 'package:intexgram/Presentation/Screens/pages/pages/main_page.dart'
    as _i4;
import 'package:intexgram/Presentation/Screens/pages/pages/notifications_page.dart'
    as _i6;
import 'package:intexgram/Presentation/Screens/pages/pages/profile_page.dart'
    as _i7;
import 'package:intexgram/Presentation/Screens/pages/pages/search_page.dart'
    as _i5;

class FlutterRouter extends _i8.RootStackRouter {
  FlutterRouter({
    _i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i10.AuthGuard authGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    MainScreenRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    SignInPageRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.SignInPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.SignUpPage(),
      );
    },
    MainPageRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.MainPage(),
      );
    },
    SearchPageRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.SearchPage(),
      );
    },
    NotificationsPageRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.NotificationsPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfilePage(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          MainScreenRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i8.RouteConfig(
              MainPageRoute.name,
              path: 'main-page',
              parent: MainScreenRoute.name,
            ),
            _i8.RouteConfig(
              SearchPageRoute.name,
              path: 'search-page',
              parent: MainScreenRoute.name,
            ),
            _i8.RouteConfig(
              MainPageRoute.name,
              path: 'main-page',
              parent: MainScreenRoute.name,
            ),
            _i8.RouteConfig(
              NotificationsPageRoute.name,
              path: 'notifications-page',
              parent: MainScreenRoute.name,
            ),
            _i8.RouteConfig(
              ProfilePageRoute.name,
              path: 'profile-page',
              parent: MainScreenRoute.name,
            ),
          ],
        ),
        _i8.RouteConfig(
          SignInPageRoute.name,
          path: '/sign-in-page',
        ),
        _i8.RouteConfig(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreenRoute extends _i8.PageRouteInfo<void> {
  const MainScreenRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainScreenRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInPageRoute extends _i8.PageRouteInfo<void> {
  const SignInPageRoute()
      : super(
          SignInPageRoute.name,
          path: '/sign-in-page',
        );

  static const String name = 'SignInPageRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpPageRoute extends _i8.PageRouteInfo<void> {
  const SignUpPageRoute()
      : super(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        );

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i4.MainPage]
class MainPageRoute extends _i8.PageRouteInfo<void> {
  const MainPageRoute()
      : super(
          MainPageRoute.name,
          path: 'main-page',
        );

  static const String name = 'MainPageRoute';
}

/// generated route for
/// [_i5.SearchPage]
class SearchPageRoute extends _i8.PageRouteInfo<void> {
  const SearchPageRoute()
      : super(
          SearchPageRoute.name,
          path: 'search-page',
        );

  static const String name = 'SearchPageRoute';
}

/// generated route for
/// [_i6.NotificationsPage]
class NotificationsPageRoute extends _i8.PageRouteInfo<void> {
  const NotificationsPageRoute()
      : super(
          NotificationsPageRoute.name,
          path: 'notifications-page',
        );

  static const String name = 'NotificationsPageRoute';
}

/// generated route for
/// [_i7.ProfilePage]
class ProfilePageRoute extends _i8.PageRouteInfo<void> {
  const ProfilePageRoute()
      : super(
          ProfilePageRoute.name,
          path: 'profile-page',
        );

  static const String name = 'ProfilePageRoute';
}
