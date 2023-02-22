import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';

import '../../../../Domain/entities/post_entity.dart';

part 'profile_page_state.freezed.dart';

@freezed
class ProfilePageState with _$ProfilePageState {
  const factory ProfilePageState.initial(
    String userEmail,
  ) = Initial;

  const factory ProfilePageState.ready(
    PersonEntity user,
    String currentUserEmail,
    List<PostEntity> posts,
    bool? isFollowing,
  ) = Ready;

  const factory ProfilePageState.loading(
    PersonEntity user,
    String currentUserEmail,
    List<PostEntity> posts,
    bool? isFollowing,
  ) = Loading;
}
