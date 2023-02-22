import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';

part 'main_screen_state.freezed.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState.initial() = Initial;

  const factory MainScreenState.userLoaded(
    PersonEntity user,
    CameraController cameraController,
  ) = UserLoaded;
}
