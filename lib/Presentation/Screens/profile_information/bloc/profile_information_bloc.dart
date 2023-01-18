import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/change_photo_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/update_current_person_use_case.dart';
import 'package:path/path.dart';

import 'profile_information_event.dart';
import 'profile_information_state.dart';

class ProfileInformationBloc
    extends Bloc<ProfileInformationEvent, ProfileInformationState> {
  final UpdateCurrentPersonUseCase updateCurrentPerson;
  final ChangePhotoUseCase changePhoto;
  ProfileInformationBloc(
    this.updateCurrentPerson,
    this.changePhoto,
  ) : super(const Initial()) {
    on<ProfileInformationEvent>(
      (event, emit) async {
        await event.when(
          submitButtonPressed: ((
            nickName,
            userName,
            description,
            user,
            newPhoto,
          ) async =>
              await _submitButtonPressed(
                nickName,
                userName,
                description,
                user,
                newPhoto,
                emit,
              )),
          setToInitial: (() async => emit.call(const Initial())),
          updatePhoto: ((photo) async => emit.call(PhotoUpdated(photo))),
        );
      },
    );
  }

  FutureOr<void> _submitButtonPressed(
    String nickName,
    String userName,
    String description,
    PersonEntity user,
    File? newPhoto,
    Emitter<ProfileInformationState> emit,
  ) async {
    bool isChanged = false;
    if (nickName != '' && userName != '') {
      if (newPhoto == null) {
        if (userName != user.userName ||
            nickName != user.nickName ||
            description != user.description) {
          await updateCurrentPerson(
            UpdateCurrentPersonParams(
              email: user.email,
              nickName: format(nickName),
              userName: format(userName),
              description: formatDescription(description),
            ),
          );
          isChanged = true;
          emit(Exit(isChanged));
        } else {
          emit(Exit(isChanged));
        }
      } else {
        await changePhoto(ChangePhotoParams(photo: newPhoto));

        await updateCurrentPerson(
          UpdateCurrentPersonParams(
            profileImagePath: "images/${basename(newPhoto.path)}",
            email: user.email,
            nickName: format(nickName),
            userName: format(userName),
            description: formatDescription(description),
          ),
        );
        isChanged = true;
        emit(Exit(isChanged));
      }
    }
  }

  format(String text) {
    while (text.endsWith(' ')) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  formatDescription(String text) {
    String result = '';
    for (String string in text.split('\n')) {
      while (string.endsWith(' ')) {
        string = string.substring(0, string.length - 1);
      }
      result = '$result$string\n';
    }
    var preResult = result.split(('\n'));
    result = '';
    while (preResult.last.isEmpty) {
      preResult.removeLast();
    }
    for (String string in preResult) {
      result = '$result$string\n';
    }
    while (
        result.endsWith('\n') || result.endsWith(' ') || result.endsWith(" ")) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }
}
