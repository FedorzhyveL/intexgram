import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/add_to_favorite_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/get_post_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/remove_from_favorite_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/remove_like_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/set_like_use_case.dart';

import 'user_list_of_posts_event.dart';
import 'user_list_of_posts_state.dart';

class UserListOfPostsBloc
    extends Bloc<UserListOfPostsEvent, UserListOfPostsState> {
  final GetPostUseCase getPost;
  final SetLikeUseCase setLikeUseCase;
  final RemoveLikeUseCase removeLikeUseCase;
  final AddToFavoriteUseCase addToFavoriteUseCase;
  final RemoveFromFavoriteUseCase removeFromFavoriteUseCase;
  final List<PostEntity> posts;

  UserListOfPostsBloc(
    this.getPost,
    this.setLikeUseCase,
    this.removeLikeUseCase,
    this.addToFavoriteUseCase,
    this.removeFromFavoriteUseCase,
    this.posts,
  ) : super(Initial(posts)) {
    on<UserListOfPostsEvent>(
      (event, emit) async {
        await event.when(
          setLike: ((posts, post, index) async => await _setLikeToPost(
                posts,
                post,
                index,
                emit,
              )),
          removeLike: ((posts, post, index) async => await _removeLikeFromPost(
                posts,
                post,
                index,
                emit,
              )),
          addPostToFavorite: ((posts, post, index) async =>
              await _addPostToFavorite(
                posts,
                post,
                index,
                emit,
              )),
          removePostFromFavorite: ((posts, post, index) async =>
              await _removePostFromFavorite(
                posts,
                post,
                index,
                emit,
              )),
          setToInitial: ((posts) async => emit.call(Initial(posts))),
        );
      },
    );
  }

  Future<FutureOr<void>> _setLikeToPost(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    Emitter<UserListOfPostsState> emit,
  ) async {
    final postOrFailure = await setLikeUseCase(SetLikeParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );
    emit(PostUpdated(posts));
  }

  Future<FutureOr<void>> _removeLikeFromPost(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    Emitter<UserListOfPostsState> emit,
  ) async {
    final postOrFailure = await removeLikeUseCase(RemoveLikeParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );
    emit(PostUpdated(posts));
  }

  Future<FutureOr<void>> _addPostToFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    Emitter<UserListOfPostsState> emit,
  ) async {
    final postOrFailure = await addToFavoriteUseCase(AddToFavoriteParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );
    emit(PostUpdated(posts));
  }

  Future<FutureOr<void>> _removePostFromFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    Emitter<UserListOfPostsState> emit,
  ) async {
    final postOrFailure =
        await removeFromFavoriteUseCase(RemoveFromFavoriteParams(post));

    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );
    emit(PostUpdated(posts));
  }
}
