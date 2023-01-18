import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';

part 'favorites_event.freezed.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.load() = Load;

  const factory FavoritesEvent.setLike(
    List<PostEntity> posts,
    PostEntity post,
    int index,
  ) = SetLike;

  const factory FavoritesEvent.removeLike(
    List<PostEntity> posts,
    PostEntity post,
    int index,
  ) = RemoveLike;

  const factory FavoritesEvent.addToFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
  ) = AddToFavorite;

  const factory FavoritesEvent.removeFromFavorite(
    List<PostEntity> posts,
    PostEntity post,
    int index,
  ) = RemoveFromFavorite;

  const factory FavoritesEvent.update(
    List<PostEntity> posts,
  ) = Update;
}
