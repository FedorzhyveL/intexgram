import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/comment_entity.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';

part 'comments_page_state.freezed.dart';

@freezed
class CommentsPageState with _$CommentsPageState {
  const factory CommentsPageState.initial({
    required PostEntity post,
  }) = Initial;

  const factory CommentsPageState.descriptionLoaded({
    required PostEntity post,
    required List<CommentEntity> comments,
    required PersonEntity currentUser,
  }) = DescriptionLoaded;

  const factory CommentsPageState.loaded({
    required PostEntity post,
    required List<CommentEntity> comments,
    required PersonEntity currentUser,
    required bool allowPublish,
  }) = Loaded;
}
