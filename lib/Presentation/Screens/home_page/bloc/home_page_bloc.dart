import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_persons_from_collection_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/add_to_favorite_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/get_user_posts_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/remove_from_favorite_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/remove_like_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/set_like_use_case.dart';

import 'home_page_event.dart';
import 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetCurrentPersonUseCase getCurrentPerson;
  final GetPersonsFromCollectionUseCase getPersonsFromCollection;
  final GetUserPostsUseCase getUserPosts;
  final SetLikeUseCase setLikeUseCase;
  final RemoveLikeUseCase removeLikeUseCase;
  final AddToFavoriteUseCase addToFavoriteUseCase;
  final RemoveFromFavoriteUseCase removeFromFavoriteUseCase;
  HomePageBloc(
    this.getCurrentPerson,
    this.getPersonsFromCollection,
    this.getUserPosts,
    this.setLikeUseCase,
    this.removeLikeUseCase,
    this.addToFavoriteUseCase,
    this.removeFromFavoriteUseCase,
  ) : super(const Initial()) {
    on<HomePageEvent>(
      (event, emit) async {
        await event.when(
          loadUser: () async => await _loadUser(
            emit,
          ),
          loadGallery: (user) async => await _loadGallery(
            user,
            emit,
          ),
          setLike: (
            posts,
            post,
            index,
            following,
          ) async =>
              await _setLikeToPost(
            posts,
            post,
            index,
            following,
            emit,
          ),
          removeLike: (
            posts,
            post,
            index,
            following,
          ) async =>
              await _removeLikeFromPost(
            posts,
            post,
            index,
            following,
            emit,
          ),
          addToFavorite: (
            posts,
            post,
            index,
            following,
          ) async =>
              await _addPostToFavorite(
            posts,
            post,
            index,
            following,
            emit,
          ),
          removeFromFavorite: (
            posts,
            post,
            index,
            following,
          ) async =>
              await _removePostFromFavorite(
            posts,
            post,
            index,
            following,
            emit,
          ),
          update: ((posts, following) async =>
              emit.call(GalleryReady(posts, following))),
        );
      },
    );
  }

  FutureOr<void> _loadUser(
    Emitter<HomePageState> emit,
  ) async {
    var failureOrPerson = await getCurrentPerson(
      GetCurrentPersonParams(
        email: FirebaseAuth.instance.currentUser!.email!,
        fromCache: false,
      ),
    );

    failureOrPerson.fold(
      (l) => null,
      (user) {
        emit(Ready(user));
      },
    );
  }

  FutureOr<void> _loadGallery(
    PersonEntity user,
    Emitter<HomePageState> emit,
  ) async {
    List<PostEntity> followingPosts = [];
    List<PersonEntity> followingList = [user];
    final followingOrFailure = await getPersonsFromCollection(
        GetPersonsFromCollectionParams("Users", "Following", user.email));

    await followingOrFailure.fold(
      (l) => null,
      (following) async {
        followingList.addAll(following);
        for (var user in following) {
          final userOrFailure =
              await getUserPosts(GetUserPostsParams(email: user.email));
          userOrFailure.fold(
            (l) => null,
            (posts) => followingPosts.addAll(posts),
          );
        }
      },
    );

    followingPosts.sort((a, b) => a.creationTime.compareTo(b.creationTime));
    followingPosts = followingPosts.reversed.toList();
    emit(GalleryReady(followingPosts, followingList));
  }

  Future<FutureOr<void>> _setLikeToPost(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    List<PersonEntity> following,
    Emitter<HomePageState> emit,
  ) async {
    final postOrFailure = await setLikeUseCase(SetLikeParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );
    emit(Updated(posts, following));
  }

  Future<FutureOr<void>> _removeLikeFromPost(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    List<PersonEntity> following,
    Emitter<HomePageState> emit,
  ) async {
    final postOrFailure = await removeLikeUseCase(RemoveLikeParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );
    emit(Updated(posts, following));
  }

  Future<FutureOr<void>> _addPostToFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    List<PersonEntity> following,
    Emitter<HomePageState> emit,
  ) async {
    final postOrFailure = await addToFavoriteUseCase(AddToFavoriteParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );
    emit(Updated(posts, following));
  }

  Future<FutureOr<void>> _removePostFromFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    List<PersonEntity> following,
    Emitter<HomePageState> emit,
  ) async {
    final postOrFailure =
        await removeFromFavoriteUseCase(RemoveFromFavoriteParams(post));
    postOrFailure.fold(
      (l) => null,
      (post) => posts[index] = post,
    );
    emit(Updated(posts, following));
  }
}
