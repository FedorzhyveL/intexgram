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
  final PostEntity post;
  CommentsPageBloc(
    this.getCurrentPerson,
    this.addComment,
    this.getComments,
    this.post,
  ) : super(Initial(post: post)) {
    on<CommentsPageEvent>(
      (event, emit) async {
        await event.when(
          loadDescription: (post) async => await _loadDescription(
            post,
            emit,
          ),
          loadAllComments: (post, comments, currentUser) async =>
              await _loadAllComments(
            post,
            comments,
            currentUser,
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
  }

  FutureOr<void> _loadDescription(
    PostEntity post,
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
    emit(
      DescriptionLoaded(
        post: post,
        comments: comments,
        currentUser: user,
      ),
    );
  }

  FutureOr<void> _loadAllComments(
    PostEntity post,
    List<CommentEntity> comments,
    PersonEntity user,
    Emitter<CommentsPageState> emit,
  ) async {
    List<CommentEntity> allComments = [];
    allComments.addAll(comments);
    final commentsOrFailure = await getComments(GetCommentsParams(post));
    commentsOrFailure.fold(
        (l) => null, (comments) => allComments.addAll(comments));

    emit(
      Loaded(
        comments: allComments,
        currentUser: user,
        allowPublish: false,
        post: post,
      ),
    );
  }

  FutureOr<void> _commentValueChanged(
    Loaded state,
    String value,
    Emitter<CommentsPageState> emit,
  ) {
    if (value.isEmpty) {
      emit(
        Loaded(
          comments: state.comments,
          currentUser: state.currentUser,
          allowPublish: false,
          post: post,
        ),
      );
    }
    if (value.isNotEmpty) {
      emit(
        Loaded(
          comments: state.comments,
          currentUser: state.currentUser,
          allowPublish: false,
          post: post,
        ),
      );
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
