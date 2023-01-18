import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.initial() = Initial;

  const factory HomePageState.ready(
    PersonEntity user,
  ) = Ready;

  const factory HomePageState.galleryReady(
    List<PostEntity> posts,
    List<PersonEntity> following,
  ) = GalleryReady;

  const factory HomePageState.updated(
    List<PostEntity> posts,
    List<PersonEntity> following,
  ) = Updated;
}
