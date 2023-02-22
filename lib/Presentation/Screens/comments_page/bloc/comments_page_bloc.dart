import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/entities/comment_entity.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/usecases/comments_use_cases/add_comment_use_case.dart';
import 'package:intexgram/Domain/usecases/comments_use_cases/get_comments_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';

import 'comments_page_event.dart';
import 'comments_page_state.dart';

class CommentsPageBloc extends Bloc<CommentsPageEvent, CommentsPageState> {
  final GetCurrentPersonUseCase getCurrentPerson;
  final GetCommentsUseCase getComments;
  final AddCommentUseCase addComment;

  CommentsPageBloc(
    this.getCurrentPerson,
    this.addComment,
    this.getComments,
    PostEntity post,
  ) : super(Initial(post: post)) {
    on<CommentsPageEvent>(
      (event, emit) async {
        await event.when(
          loadDescription: (post, state) async => await _loadDescription(
            post,
            state,
            emit,
          ),
          commentValueChanged: (state, value) async =>
              await _commentValueChanged(
            state,
            value,
            emit,
          ),
          addComment: (post, text) async => await _addComment(
            post,
            text,
            emit,
          ),
        );
      },
    );
    add(LoadDescription(post, state));
  }

  FutureOr<void> _loadDescription(
    PostEntity post,
    CommentsPageState state,
    Emitter<CommentsPageState> emit,
  ) async {
    List<CommentEntity> comments = [];
    comments.add(
      CommentEntity(
        user: post.owner,
        creationTime: post.creationTime,
        text: post.description == null ? '' : post.description!,
        id: post.id,
      ),
    );
    final userOrFailure = await getCurrentPerson(
      GetCurrentPersonParams(
        email: FirebaseAuth.instance.currentUser!.email!,
        fromCache: false,
      ),
    );
    late PersonEntity user;
    userOrFailure.fold((l) => {}, ((result) => user = result));

    if (state is Loaded) {
      emit(
        Loading(
          state.post,
          state.comments,
          state.currentUser,
          state.allowPublish,
        ),
      );
    } else {
      emit(
        Loading(
          post,
          comments,
          user,
          false,
        ),
      );
    }

    final commentsOrFailure = await getComments(GetCommentsParams(post));
    commentsOrFailure.fold(
        (l) => null, (commentsList) => comments.addAll(commentsList));

    emit(
      Loaded(
        post: post,
        comments: comments,
        currentUser: user,
        allowPublish: false,
      ),
    );
  }

  FutureOr<void> _commentValueChanged(
    CommentsPageState state,
    String value,
    Emitter<CommentsPageState> emit,
  ) {
    if (value.isEmpty) {
      if (state is Loaded) {
        emit(
          Loaded(
            comments: state.comments,
            currentUser: state.currentUser,
            allowPublish: false,
            post: state.post,
          ),
        );
      }
      if (state is Loading) {
        emit(
          Loading(
            state.post,
            state.comments,
            state.currentUser,
            false,
          ),
        );
      }
    }
    if (value.isNotEmpty) {
      if (state is Loaded) {
        emit(
          Loaded(
            post: state.post,
            comments: state.comments,
            currentUser: state.currentUser,
            allowPublish: true,
          ),
        );
      }
      if (state is Loading) {
        emit(
          Loading(
            state.post,
            state.comments,
            state.currentUser,
            true,
          ),
        );
      }
    }
  }

  FutureOr<void> _addComment(
    PostEntity post,
    String text,
    Emitter<CommentsPageState> emit,
  ) async {
    await addComment(AddCommentParams(post, text));
  }
}
