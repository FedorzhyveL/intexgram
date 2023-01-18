import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../Domain/entities/post_entity.dart';
part 'user_list_of_posts_state.freezed.dart';

@freezed
class UserListOfPostsState with _$UserListOfPostsState {
  const factory UserListOfPostsState.initial(
    List<PostEntity> posts,
  ) = Initial;

  const factory UserListOfPostsState.postUpdated(
    List<PostEntity> posts,
  ) = PostUpdated;
}
