import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/chek_subscription_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/subscribe_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/un_subscribe_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/get_post_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/get_user_posts_use_case.dart';
import 'package:intexgram/core/error/failure.dart';

import 'profile_page_event.dart';
import 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final CheckSubscriptionUseCase checkSubscription;
  final GetCurrentPersonUseCase getCurrentPerson;
  final GetUserPostsUseCase getUserPosts;
  final GetPostUseCase getPost;
  final SubscribeUseCase subscribe;
  final UnSubscribeUseCase unSubscribe;

  ProfilePageBloc(
    this.getCurrentPerson,
    this.getPost,
    this.checkSubscription,
    this.getUserPosts,
    this.subscribe,
    this.unSubscribe,
    String userEmail,
  ) : super(Initial(userEmail)) {
    on<ProfilePageEvent>(
      (event, emit) async {
        await event.when(
          load: (state) async => await _load(state, emit),
          subscribe: (user, currentUserEmail, posts, isSubscribed) async =>
              await _subscribe(
                  user, currentUserEmail, posts, isSubscribed, emit),
          unSubscribe: (user, currentUserEmail, posts, isSubscribed) async =>
              await _unSubscribe(
                  user, currentUserEmail, posts, isSubscribed, emit),
          loadMore: (state) async => await loadMorePosts(state, emit),
        );
      },
    );
    add(Load(Initial(userEmail)));
  }

  FutureOr<void> _load(
    ProfilePageState state,
    Emitter<ProfilePageState> emit,
  ) async {
    late String userEmail;
    state.when(
      initial: (email) => userEmail = email,
      ready: (user, currentUserEmail, posts, isFollowing) =>
          userEmail = user.email,
      loading: (user, currentUserEmail, posts, isFollowing) {},
    );
    final failureOrPerson = await getCurrentPerson(
      GetCurrentPersonParams(
        email: userEmail,
        fromCache: false,
      ),
    );
    bool subscription = false;
    return failureOrPerson.fold(
      (failure) => Failure,
      (user) async {
        if (userEmail != FirebaseAuth.instance.currentUser!.email) {
          subscription = await isSubscribed(userEmail);
        }
        List<PostEntity> userPosts = [];
        state.when(
          initial: (userEmail) => emit(
            Ready(
              user,
              FirebaseAuth.instance.currentUser!.email!,
              [],
              subscription,
            ),
          ),
          ready: (user, currentUserEmail, posts, isFollowing) =>
              userPosts.addAll(posts),
          loading: (user, currentUserEmail, posts, isFollowing) {},
        );
      },
    );
  }

  Future<bool> isSubscribed(userEmail) async {
    bool isSubscribed = false;
    final subscribedOrFailure =
        await checkSubscription(CheckSubscriptionParams(email: userEmail));
    subscribedOrFailure.fold((l) => null, (result) => isSubscribed = result);
    return isSubscribed;
  }

  _subscribe(
    PersonEntity user,
    String currentUserEmail,
    List<PostEntity> posts,
    bool? isFollowing,
    Emitter<ProfilePageState> emit,
  ) async {
    try {
      await subscribe(SubscribeParams(userEmail: user.email));
      emit(Ready(user, currentUserEmail, posts, true));
    } catch (_) {}
  }

  _unSubscribe(
    PersonEntity user,
    String currentUserEmail,
    List<PostEntity> posts,
    bool? isFollowing,
    Emitter<ProfilePageState> emit,
  ) async {
    try {
      await unSubscribe(UnSubscribeParams(userEmail: user.email));
      emit(Ready(user, currentUserEmail, posts, false));
    } catch (_) {}
  }

  Future<void> loadMorePosts(
    ProfilePageState state,
    Emitter<ProfilePageState> emit,
  ) async {
    if (state is Ready) {
      List<PostEntity> posts = [];
      posts.addAll(state.posts);

      final listOrFailure = await getUserPosts(GetUserPostsParams(
          email: state.user.email, limit: 9, startAt: state.posts.length));
      listOrFailure.fold((l) => null, (postsList) => posts.addAll(postsList));

      emit(
        Ready(
          state.user,
          state.currentUserEmail,
          posts,
          state.isFollowing,
        ),
      );
    }
  }
}
