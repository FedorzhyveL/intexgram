import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Screens/favorites_screen/bloc/favorites_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/post.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import '../../../Domain/entities/post_entity.dart';
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
      child: BlocConsumer<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          if (state is Updated) bloc.add(Update(state.posts));
        },
        builder: (context, state) {
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
              onRefresh: () {
                final refreshBloc = bloc.stream.first;
                bloc.add(const Load());
                return refreshBloc;
              },
              child: state.when(
                initial: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (posts) => content(posts),
                updated: (posts) => content(posts),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget content(List<PostEntity> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Post(
          post: posts[index],
          addToFavorite: () {
            bloc.add(
              AddToFavorite(
                posts,
                posts[index],
                index,
              ),
            );
          },
          removeFromFavorite: () {
            bloc.add(
              RemoveFromFavorite(
                posts,
                posts[index],
                index,
              ),
            );
          },
          removeLike: () {
            bloc.add(
              RemoveLike(
                posts,
                posts[index],
                index,
              ),
            );
          },
          setLike: () {
            bloc.add(
              SetLike(
                posts,
                posts[index],
                index,
              ),
            );
          },
        );
      },
    );
  }
}
