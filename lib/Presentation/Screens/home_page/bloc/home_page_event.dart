import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';

part 'home_page_event.freezed.dart';

@freezed
class HomePageEvent with _$HomePageEvent {
  const factory HomePageEvent.loadUser() = LoadUser;

  const factory HomePageEvent.loadGallery(
    PersonEntity user,
  ) = LoadGallery;

  const factory HomePageEvent.setLike(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    List<PersonEntity> following,
  ) = SetLike;

  const factory HomePageEvent.removeLike(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    List<PersonEntity> following,
  ) = RemoveLike;

  const factory HomePageEvent.addToFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    List<PersonEntity> following,
  ) = AddToFavorite;

  const factory HomePageEvent.removeFromFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
    List<PersonEntity> following,
  ) = RemoveFromFavorite;

  const factory HomePageEvent.update(
    List<PostEntity> posts,
    List<PersonEntity> following,
  ) = Update;
}
