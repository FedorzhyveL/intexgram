import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';

import 'comments_page_state.dart';

part 'comments_page_event.freezed.dart';

@freezed
abstract class CommentsPageEvent with _$CommentsPageEvent {
  const factory CommentsPageEvent.loadDescription(
    PostEntity post,
    CommentsPageState state,
  ) = LoadDescription;

  const factory CommentsPageEvent.commentValueChanged({
    required CommentsPageState currentState,
    required String value,
  }) = CommentValueChanged;

  const factory CommentsPageEvent.addComment({
    required PostEntity post,
    required String text,
  }) = AddComment;
}
