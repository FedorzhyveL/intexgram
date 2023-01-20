import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/main_screen/bloc/main_screen_bloc.dart';
import 'package:intexgram/Presentation/Screens/main_screen/loading_screen.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/main_screen_event.dart';
import 'bloc/main_screen_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainScreenBloc bloc;

  @override
  void initState() {
    bloc = MainScreenBloc(serverLocator());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc..add(const LoadUser()),
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          return state.when(
            initial: () => const LoadingScreen(),
            userLoaded: (user, cameraController) => AutoTabsRouter(
              routes: [
                const HomePageRoute(),
                const SearchPageRoute(),
                const AddPhotoRoute(),
                const FavoritesPageRoute(),
                ProfilePageRoute(userEmail: user.email),
              ],
              builder: (context, child, animation) {
                final tabsRouter = AutoTabsRouter.of(context);
                return Scaffold(
                  body: child,
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Palette.appBarColor,
                    iconSize: 30,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: tabsRouter.activeIndex,
                    onTap: (value) async {
                      if (value == 2) {
                        cameraController.resumePreview();
                      } else {
                        if (cameraController.value.isInitialized) {
                          try {
                            cameraController.pausePreview();
                          } catch (_) {}
                        }
                      }
                      tabsRouter.setActiveIndex(value);
                    },
                    items: [
                      const BottomNavigationBarItem(
                        label: 'Home',
                        icon: Icon(
                          Icons.home_outlined,
                          color: Palette.bottomNavigationIconColor,
                        ),
                        activeIcon: Icon(
                          Icons.home_filled,
                          color: Palette.bottomNavigationIconColor,
                        ),
                      ),
                      const BottomNavigationBarItem(
                        label: 'Search',
                        icon: Icon(
                          Icons.search_rounded,
                          color: Palette.bottomNavigationIconColor,
                        ),
                        activeIcon: ImageIcon(
                          AssetImage("assets/icons/search_thick.png"),
                          color: Palette.bottomNavigationIconColor,
                        ),
                      ),
                      const BottomNavigationBarItem(
                        label: 'New post',
                        icon: Icon(
                          Icons.add_box_outlined,
                          color: Palette.bottomNavigationIconColor,
                        ),
                        activeIcon: Icon(
                          Icons.add_box_rounded,
                          color: Palette.bottomNavigationIconColor,
                        ),
                      ),
                      const BottomNavigationBarItem(
                        label: 'Actions',
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: Palette.bottomNavigationIconColor,
                        ),
                        activeIcon: Icon(
                          Icons.favorite_rounded,
                          color: Palette.bottomNavigationIconColor,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'Profile',
                        icon: CircleAvatar(
                          backgroundColor: Palette.appBarColor,
                          radius: 15,
                          child: CircleAvatar(
                            radius: 14,
                            foregroundImage: CachedNetworkImageProvider(
                                user.profilePicturePath),
                          ),
                        ),
                        activeIcon: CircleAvatar(
                          backgroundColor: Palette.bottomNavigationIconColor,
                          radius: 15,
                          child: CircleAvatar(
                            backgroundColor: Palette.appBarColor,
                            radius: 14,
                            foregroundImage: CachedNetworkImageProvider(
                                user.profilePicturePath),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
