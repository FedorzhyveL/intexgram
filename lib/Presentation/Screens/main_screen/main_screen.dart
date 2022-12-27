import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/main_screen/cubit/user_cubit.dart';
import 'package:intexgram/locator_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool liked = false;
  int likes = 321;
  int bottomIndex = 0;
  late final UserCubit cubit;

  @override
  void initState() {
    cubit = UserCubit(getCurrentPersons: serverLocator());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit..getUser(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return AutoTabsRouter(
              routes: const [
                MainPageRoute(),
                SearchPageRoute(),
                MainPageRoute(),
                NotificationsPageRoute(),
                ProfilePageRoute(),
              ],
              builder: (context, child, animation) {
                final tabsRouter = AutoTabsRouter.of(context);
                return Scaffold(
                  body: child,
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: tabsRouter.activeIndex,
                    onTap: (value) {
                      tabsRouter.setActiveIndex(value);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home_filled,
                          color: Colors.black,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.search_outlined,
                          color: Colors.black,
                        ),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.add_box_outlined,
                          color: Colors.black,
                        ),
                        label: 'New post',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.black,
                        ),
                        label: 'Actions',
                      ),
                      BottomNavigationBarItem(
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 12,
                          child: CircleAvatar(
                            radius: 120,
                            backgroundImage:
                                AssetImage('assets/photos/original.jpg'),
                          ),
                        ),
                        label: 'Profile',
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
