import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Screens/favorites_screen/bloc/favorites_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/post.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/favorites_event.dart';
import 'bloc/favorites_state.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoritesBloc bloc;
  @override
  void initState() {
    bloc = FavoritesBloc(
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
      serverLocator(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(const Load()),
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is Updated) bloc.add(Update(state.posts));
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Palette.appBarColor,
              centerTitle: true,
              title: const Text(
                'Favorites',
                style: TextStyles.appBarText,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: (() {
                final refreshBloc = bloc.stream.first;
                bloc.add(const Load());
                return refreshBloc;
              }),
              child: state is Loaded
                  ? ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return Post(
                          post: state.posts[index],
                          addToFavorite: () {
                            bloc.add(
                              AddToFavorite(
                                state.posts,
                                state.posts[index],
                                index,
                              ),
                            );
                          },
                          removeFromFavorite: () {
                            bloc.add(
                              RemoveFromFavorite(
                                state.posts,
                                state.posts[index],
                                index,
                              ),
                            );
                          },
                          removeLike: () {
                            bloc.add(
                              RemoveLike(
                                state.posts,
                                state.posts[index],
                                index,
                              ),
                            );
                          },
                          setLike: () {
                            bloc.add(
                              SetLike(
                                state.posts,
                                state.posts[index],
                                index,
                              ),
                            );
                          },
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        },
      ),
    );
  }
}
