import 'dart:async';
import 'dart:developer';

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
  final String userEmail;

  ProfilePageBloc(
    this.getCurrentPerson,
    this.getPost,
    this.checkSubscription,
    this.getUserPosts,
    this.subscribe,
    this.unSubscribe,
    this.userEmail,
  ) : super(Initial(userEmail)) {
    on<ProfilePageEvent>(
      (event, emit) async {
        await event.when(
          load: ((user) async => await _load(
                user,
                emit,
              )),
          subscribe: ((
            user,
            currentUserEmail,
            posts,
            isSubscribed,
          ) async =>
              await _subscribe(
                user,
                currentUserEmail,
                posts,
                isSubscribed,
                emit,
              )),
          unSubscribe: ((
            user,
            currentUserEmail,
            posts,
            isSubscribed,
          ) async =>
              await _unSubscribe(
                user,
                currentUserEmail,
                posts,
                isSubscribed,
                emit,
              )),
        );
      },
    );
  }

  FutureOr<void> _load(
    String userEmail,
    Emitter<ProfilePageState> emit,
  ) async {
    final failureOrPerson = await getCurrentPerson(
      GetCurrentPersonParams(
        email: userEmail,
        fromCache: false,
      ),
    );
    final subscription = await isSubscribed(userEmail);
    return failureOrPerson.fold(
      (failure) => Failure,
      (user) async {
        if (userEmail != FirebaseAuth.instance.currentUser!.email) {
          emit(
            Ready(
              user,
              FirebaseAuth.instance.currentUser!.email!,
              [],
              subscription,
            ),
          );
        } else {
          emit(
            Ready(
              user,
              FirebaseAuth.instance.currentUser!.email!,
              [],
              subscription,
            ),
          );
        }
        List<PostEntity> userPosts = [];
        final listOrFailure =
            await getUserPosts(GetUserPostsParams(email: user.email));
        listOrFailure.fold((l) => null, (posts) => userPosts = posts);
        emit(
          Ready(
            user,
            FirebaseAuth.instance.currentUser!.email!,
            userPosts,
            subscription,
          ),
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
    } catch (e) {
      log(e.toString());
    }
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
    } catch (e) {
      log(e.toString());
    }
  }
}
