import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';

import '../../../../Domain/entities/post_entity.dart';
import 'profile_page_state.dart';

part 'profile_page_event.freezed.dart';

@freezed
class ProfilePageEvent with _$ProfilePageEvent {
  const factory ProfilePageEvent.load(
    ProfilePageState state,
  ) = Load;

  const factory ProfilePageEvent.loadMore(
    ProfilePageState state,
  ) = LoadMore;

  const factory ProfilePageEvent.subscribe(
    PersonEntity user,
    String currentUserEmail,
    List<PostEntity> posts,
    bool? isFollowing,
  ) = Subscribe;

  const factory ProfilePageEvent.unSubscribe(
    PersonEntity user,
    String currentUserEmail,
    List<PostEntity> posts,
    bool? isFollowing,
  ) = UnSubscribe;
}
