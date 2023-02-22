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
import 'dart:io' as _i17;

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:intexgram/Domain/entities/person_entity.dart' as _i18;
import 'package:intexgram/Domain/entities/post_entity.dart' as _i19;
import 'package:intexgram/Presentation/Routes/auth_guard.dart' as _i16;
import 'package:intexgram/Presentation/Screens/add_photo_screen/add_photo_page.dart'
    as _i12;
import 'package:intexgram/Presentation/Screens/add_post_page/add_post_page.dart'
    as _i5;
import 'package:intexgram/Presentation/Screens/authorization/sign_in/sign_in.dart'
    as _i3;
import 'package:intexgram/Presentation/Screens/authorization/sign_up/sign_up.dart'
    as _i4;
import 'package:intexgram/Presentation/Screens/comments_page/comments_page.dart'
    as _i9;
import 'package:intexgram/Presentation/Screens/favorites_screen/favorites_page.dart'
    as _i13;
import 'package:intexgram/Presentation/Screens/home_page/home_page.dart'
    as _i10;
import 'package:intexgram/Presentation/Screens/list_of_users/list_of_users.dart'
    as _i8;
import 'package:intexgram/Presentation/Screens/main_screen/main_screen.dart'
    as _i1;
import 'package:intexgram/Presentation/Screens/profile_information/profile_information.dart'
    as _i6;
import 'package:intexgram/Presentation/Screens/profile_page/profile_page.dart'
    as _i2;
import 'package:intexgram/Presentation/Screens/search_screen/search_page.dart'
    as _i11;
import 'package:intexgram/Presentation/Screens/user_list_of_posts/user_list_of_posts.dart'
    as _i7;

class FlutterRouter extends _i14.RootStackRouter {
  FlutterRouter({
    _i15.GlobalKey<_i15.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i16.AuthGuard authGuard;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    MainScreenRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final args = routeData.argsAs<ProfilePageRouteArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.ProfilePage(
          key: args.key,
          userEmail: args.userEmail,
        ),
        transitionsBuilder: _i14.TransitionsBuilders.slideBottom,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignInPageRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.SignInPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignUpPage(),
      );
    },
    AddPostPageRoute.name: (routeData) {
      final args = routeData.argsAs<AddPostPageRouteArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i5.AddPostPage(
          key: args.key,
          photo: args.photo,
        ),
      );
    },
    ProfileInformationRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileInformationRouteArgs>();
      return _i14.AdaptivePage<bool>(
        routeData: routeData,
        child: _i6.ProfileInformation(
          key: args.key,
          user: args.user,
        ),
      );
    },
    UserListOfPostsRoute.name: (routeData) {
      final args = routeData.argsAs<UserListOfPostsRouteArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.UserListOfPosts(
          key: args.key,
          posts: args.posts,
          position: args.position,
        ),
      );
    },
    ListOfUsersRoute.name: (routeData) {
      final args = routeData.argsAs<ListOfUsersRouteArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.ListOfUsers(
          key: args.key,
          docId: args.docId,
          appBarLabel: args.appBarLabel,
        ),
      );
    },
    CommentsPageRoute.name: (routeData) {
      final args = routeData.argsAs<CommentsPageRouteArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i9.CommentsPage(
          key: args.key,
          post: args.post,
        ),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i10.HomePage(),
      );
    },
    SearchPageRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i11.SearchPage(),
      );
    },
    AddPhotoRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i12.AddPhoto(),
      );
    },
    FavoritesPageRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i13.FavoritesPage(),
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          MainScreenRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i14.RouteConfig(
              HomePageRoute.name,
              path: 'home-page',
              parent: MainScreenRoute.name,
            ),
            _i14.RouteConfig(
              SearchPageRoute.name,
              path: 'search-page',
              parent: MainScreenRoute.name,
            ),
            _i14.RouteConfig(
              AddPhotoRoute.name,
              path: 'add-photo',
              parent: MainScreenRoute.name,
            ),
            _i14.RouteConfig(
              FavoritesPageRoute.name,
              path: 'favorites-page',
              parent: MainScreenRoute.name,
            ),
            _i14.RouteConfig(
              ProfilePageRoute.name,
              path: 'profile-page',
              parent: MainScreenRoute.name,
            ),
          ],
        ),
        _i14.RouteConfig(
          ProfilePageRoute.name,
          path: 'profile-page',
        ),
        _i14.RouteConfig(
          SignInPageRoute.name,
          path: '/sign-in-page',
        ),
        _i14.RouteConfig(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        ),
        _i14.RouteConfig(
          AddPostPageRoute.name,
          path: '/add-post-page',
        ),
        _i14.RouteConfig(
          ProfileInformationRoute.name,
          path: '/profile-information',
        ),
        _i14.RouteConfig(
          UserListOfPostsRoute.name,
          path: '/user-list-of-posts',
        ),
        _i14.RouteConfig(
          ListOfUsersRoute.name,
          path: '/list-of-users',
        ),
        _i14.RouteConfig(
          CommentsPageRoute.name,
          path: '/comments-page',
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreenRoute extends _i14.PageRouteInfo<void> {
  const MainScreenRoute({List<_i14.PageRouteInfo>? children})
      : super(
          MainScreenRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';
}

/// generated route for
/// [_i2.ProfilePage]
class ProfilePageRoute extends _i14.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({
    _i15.Key? key,
    required String userEmail,
  }) : super(
          ProfilePageRoute.name,
          path: 'profile-page',
          args: ProfilePageRouteArgs(
            key: key,
            userEmail: userEmail,
          ),
        );

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({
    this.key,
    required this.userEmail,
  });

  final _i15.Key? key;

  final String userEmail;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, userEmail: $userEmail}';
  }
}

/// generated route for
/// [_i3.SignInPage]
class SignInPageRoute extends _i14.PageRouteInfo<void> {
  const SignInPageRoute()
      : super(
          SignInPageRoute.name,
          path: '/sign-in-page',
        );

  static const String name = 'SignInPageRoute';
}

/// generated route for
/// [_i4.SignUpPage]
class SignUpPageRoute extends _i14.PageRouteInfo<void> {
  const SignUpPageRoute()
      : super(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        );

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i5.AddPostPage]
class AddPostPageRoute extends _i14.PageRouteInfo<AddPostPageRouteArgs> {
  AddPostPageRoute({
    _i15.Key? key,
    required _i17.File photo,
  }) : super(
          AddPostPageRoute.name,
          path: '/add-post-page',
          args: AddPostPageRouteArgs(
            key: key,
            photo: photo,
          ),
        );

  static const String name = 'AddPostPageRoute';
}

class AddPostPageRouteArgs {
  const AddPostPageRouteArgs({
    this.key,
    required this.photo,
  });

  final _i15.Key? key;

  final _i17.File photo;

  @override
  String toString() {
    return 'AddPostPageRouteArgs{key: $key, photo: $photo}';
  }
}

/// generated route for
/// [_i6.ProfileInformation]
class ProfileInformationRoute
    extends _i14.PageRouteInfo<ProfileInformationRouteArgs> {
  ProfileInformationRoute({
    _i15.Key? key,
    required _i18.PersonEntity user,
  }) : super(
          ProfileInformationRoute.name,
          path: '/profile-information',
          args: ProfileInformationRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'ProfileInformationRoute';
}

class ProfileInformationRouteArgs {
  const ProfileInformationRouteArgs({
    this.key,
    required this.user,
  });

  final _i15.Key? key;

  final _i18.PersonEntity user;

  @override
  String toString() {
    return 'ProfileInformationRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i7.UserListOfPosts]
class UserListOfPostsRoute
    extends _i14.PageRouteInfo<UserListOfPostsRouteArgs> {
  UserListOfPostsRoute({
    _i15.Key? key,
    required List<_i19.PostEntity> posts,
    required double position,
  }) : super(
          UserListOfPostsRoute.name,
          path: '/user-list-of-posts',
          args: UserListOfPostsRouteArgs(
            key: key,
            posts: posts,
            position: position,
          ),
        );

  static const String name = 'UserListOfPostsRoute';
}

class UserListOfPostsRouteArgs {
  const UserListOfPostsRouteArgs({
    this.key,
    required this.posts,
    required this.position,
  });

  final _i15.Key? key;

  final List<_i19.PostEntity> posts;

  final double position;

  @override
  String toString() {
    return 'UserListOfPostsRouteArgs{key: $key, posts: $posts, position: $position}';
  }
}

/// generated route for
/// [_i8.ListOfUsers]
class ListOfUsersRoute extends _i14.PageRouteInfo<ListOfUsersRouteArgs> {
  ListOfUsersRoute({
    _i15.Key? key,
    required String docId,
    required String appBarLabel,
  }) : super(
          ListOfUsersRoute.name,
          path: '/list-of-users',
          args: ListOfUsersRouteArgs(
            key: key,
            docId: docId,
            appBarLabel: appBarLabel,
          ),
        );

  static const String name = 'ListOfUsersRoute';
}

class ListOfUsersRouteArgs {
  const ListOfUsersRouteArgs({
    this.key,
    required this.docId,
    required this.appBarLabel,
  });

  final _i15.Key? key;

  final String docId;

  final String appBarLabel;

  @override
  String toString() {
    return 'ListOfUsersRouteArgs{key: $key, docId: $docId, appBarLabel: $appBarLabel}';
  }
}

/// generated route for
/// [_i9.CommentsPage]
class CommentsPageRoute extends _i14.PageRouteInfo<CommentsPageRouteArgs> {
  CommentsPageRoute({
    _i15.Key? key,
    required _i19.PostEntity post,
  }) : super(
          CommentsPageRoute.name,
          path: '/comments-page',
          args: CommentsPageRouteArgs(
            key: key,
            post: post,
          ),
        );

  static const String name = 'CommentsPageRoute';
}

class CommentsPageRouteArgs {
  const CommentsPageRouteArgs({
    this.key,
    required this.post,
  });

  final _i15.Key? key;

  final _i19.PostEntity post;

  @override
  String toString() {
    return 'CommentsPageRouteArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i10.HomePage]
class HomePageRoute extends _i14.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: 'home-page',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i11.SearchPage]
class SearchPageRoute extends _i14.PageRouteInfo<void> {
  const SearchPageRoute()
      : super(
          SearchPageRoute.name,
          path: 'search-page',
        );

  static const String name = 'SearchPageRoute';
}

/// generated route for
/// [_i12.AddPhoto]
class AddPhotoRoute extends _i14.PageRouteInfo<void> {
  const AddPhotoRoute()
      : super(
          AddPhotoRoute.name,
          path: 'add-photo',
        );

  static const String name = 'AddPhotoRoute';
}

/// generated route for
/// [_i13.FavoritesPage]
class FavoritesPageRoute extends _i14.PageRouteInfo<void> {
  const FavoritesPageRoute()
      : super(
          FavoritesPageRoute.name,
          path: 'favorites-page',
        );

  static const String name = 'FavoritesPageRoute';
}
