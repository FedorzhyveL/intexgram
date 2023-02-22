import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_photo_event.freezed.dart';

@freezed
class AddPhotoEvent with _$AddPhotoEvent {
  const factory AddPhotoEvent.initializeCameraController(
    CameraController cameraController,
  ) = InitializeCameraController;
}
