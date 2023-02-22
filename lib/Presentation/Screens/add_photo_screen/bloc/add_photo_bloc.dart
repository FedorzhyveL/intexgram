import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

import 'add_photo_event.dart';
import 'add_photo_state.dart';

class AddPhotoBloc extends Bloc<AddPhotoEvent, AddPhotoState> {
  AddPhotoBloc(CameraController controller) : super(Initial(controller)) {
    on<AddPhotoEvent>(
      (event, emit) async {
        await event.when(
          initializeCameraController: (cameraController) async =>
              await _loadCameras(cameraController, emit),
        );
      },
    );
    add(InitializeCameraController(controller));
  }

  FutureOr<void> _loadCameras(
    CameraController cameraController,
    Emitter<AddPhotoState> emit,
  ) async {
    try {
      await cameraController.initialize();

      emit(CamerasReady(controller: cameraController));
    } catch (e) {
      log(e.toString());
    }
  }
}
