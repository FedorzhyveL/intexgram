import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/add_to_favorite_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/get_favorite_posts_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/remove_from_favorite_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/remove_like_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/set_like_use_case.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritePostsUseCase getFavoritePosts;
  final SetLikeUseCase setLikeUseCase;
  final RemoveLikeUseCase removeLikeUseCase;
  final AddToFavoriteUseCase addToFavoriteUseCase;
  final RemoveFromFavoriteUseCase removeFromFavoriteUseCase;
  FavoritesBloc(
    this.getFavoritePosts,
    this.setLikeUseCase,
    this.removeLikeUseCase,
    this.addToFavoriteUseCase,
    this.removeFromFavoriteUseCase,
  ) : super(const Initial()) {
    on<FavoritesEvent>(
      (event, emit) async {
        await event.when(
          load: () async => await _loadFavoritesPosts(
            emit,
          ),
          setLike: (
            posts,
            post,
            index,
          ) async =>
              await _setLikeToPost(
            posts,
            post,
            index,
            emit,
          ),
          removeLike: (
            posts,
            post,
            index,
          ) async =>
              await _removeLikeFromPost(
            posts,
            post,
            index,
            emit,
          ),
          addToFavorite: (
            posts,
            post,
            index,
          ) async =>
              await _addPostToFavorite(
            posts,
            post,
            index,
            emit,
          ),
          removeFromFavorite: (
            posts,
            post,
            index,
          ) async =>
              await _removePostFromFavorite(
            posts,
            post,
            index,
            emit,
          ),
          update: (posts) async => emit.call(Loaded(posts: posts)),
        );
      },
    );
  }

  FutureOr<void> _loadFavoritesPosts(
    Emitter<FavoritesState> emit,
  ) async {
    emit(const Initial());
    List<PostEntity> posts = [];
    final postsOrFailure = await getFavoritePosts(GetFavoritePostsParams(
        email: FirebaseAuth.instance.currentUser!.email!));
    postsOrFailure.fold((l) => null, (result) => posts = result);

    emit(Loaded(posts: posts));
  }

  Future<FutureOr<void>> _setLikeToPost(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    Emitter<FavoritesState> emit,
  ) async {
    final postOrFailure = await setLikeUseCase(SetLikeParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );

    emit(Updated(posts: posts));
  }

  Future<FutureOr<void>> _removeLikeFromPost(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    Emitter<FavoritesState> emit,
  ) async {
    final postOrFailure = await removeLikeUseCase(RemoveLikeParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );

    emit(Updated(posts: posts));
  }

  Future<FutureOr<void>> _addPostToFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    Emitter<FavoritesState> emit,
  ) async {
    final postOrFailure = await addToFavoriteUseCase(AddToFavoriteParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );

    emit(Updated(posts: posts));
  }

  Future<FutureOr<void>> _removePostFromFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    Emitter<FavoritesState> emit,
  ) async {
    final postOrFailure =
        await removeFromFavoriteUseCase(RemoveFromFavoriteParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );

    emit(Updated(posts: posts));
  }
}
