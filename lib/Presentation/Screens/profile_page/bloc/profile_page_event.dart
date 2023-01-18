import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';

import '../../../../Domain/entities/post_entity.dart';

part 'profile_page_event.freezed.dart';

@freezed
class ProfilePageEvent with _$ProfilePageEvent {
  const factory ProfilePageEvent.load(
    String userEmail,
  ) = Load;

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
