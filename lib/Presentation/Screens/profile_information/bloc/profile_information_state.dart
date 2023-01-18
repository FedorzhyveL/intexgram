import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_information_state.freezed.dart';

@freezed
class ProfileInformationState with _$ProfileInformationState {
  const factory ProfileInformationState.initial() = Initial;

  const factory ProfileInformationState.photoUpdated(
    File photo,
  ) = PhotoUpdated;

  const factory ProfileInformationState.exit(
    bool isChanged,
  ) = Exit;
}
