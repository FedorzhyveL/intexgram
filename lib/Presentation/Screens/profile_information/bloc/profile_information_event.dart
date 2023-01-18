import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../Domain/entities/person_entity.dart';

part 'profile_information_event.freezed.dart';

@freezed
class ProfileInformationEvent with _$ProfileInformationEvent {
  const factory ProfileInformationEvent.submitButtonPressed(
    String nickName,
    String userName,
    String description,
    PersonEntity user,
    File? newPhoto,
  ) = SubmitButtonPressed;

  const factory ProfileInformationEvent.setToInitial() = SetToInitial;
  const factory ProfileInformationEvent.updatePhoto(
    File photo,
  ) = UpdatePhoto;
}
