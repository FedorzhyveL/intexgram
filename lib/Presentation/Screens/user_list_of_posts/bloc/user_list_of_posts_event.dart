import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../Domain/entities/post_entity.dart';
part 'user_list_of_posts_event.freezed.dart';

@freezed
class UserListOfPostsEvent with _$UserListOfPostsEvent {
  const factory UserListOfPostsEvent.setLike(
    List<PostEntity> posts,
    PostEntity post,
    int index,
  ) = SetLike;

  const factory UserListOfPostsEvent.removeLike(
    List<PostEntity> posts,
    PostEntity post,
    int index,
  ) = RemoveLike;

  const factory UserListOfPostsEvent.addPostToFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
  ) = AddPostToFavorite;

  const factory UserListOfPostsEvent.removePostFromFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
  ) = RemovePostFromFavorite;

  const factory UserListOfPostsEvent.setToInitial(
    List<PostEntity> posts,
  ) = SetToInitial;
}
