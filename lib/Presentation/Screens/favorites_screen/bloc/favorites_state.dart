import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = Initial;

  const factory FavoritesState.loaded({
    required List<PostEntity> posts,
  }) = Loaded;

  const factory FavoritesState.updated({
    required List<PostEntity> posts,
  }) = Updated;
}
