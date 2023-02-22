import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_photo_state.freezed.dart';

@freezed
class AddPhotoState with _$AddPhotoState {
  const factory AddPhotoState.initial(
    CameraController controller,
  ) = Initial;

  const factory AddPhotoState.camerasReady({
    required CameraController controller,
  }) = CamerasReady;
}
