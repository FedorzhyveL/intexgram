import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_post_state.freezed.dart';

@freezed
class AddPostState with _$AddPostState {
  const factory AddPostState.initial(File photo) = Initial;
  const factory AddPostState.loading(File photo) = Loading;
  const factory AddPostState.loaded(File photo) = Loaded;
}
