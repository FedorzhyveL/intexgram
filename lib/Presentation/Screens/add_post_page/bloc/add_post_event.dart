import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_post_event.freezed.dart';

@freezed
class AddPostEvent with _$AddPostEvent {
  const factory AddPostEvent.addPostToDb(
      {required File photo, required String description}) = AddPostToDb;
}
