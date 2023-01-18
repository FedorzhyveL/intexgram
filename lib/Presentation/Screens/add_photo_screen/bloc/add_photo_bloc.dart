import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

import 'add_photo_event.dart';
import 'add_photo_state.dart';

class AddPhotoBloc extends Bloc<AddPhotoEvent, AddPhotoState> {
  AddPhotoBloc() : super(const Initial()) {
    on<AddPhotoEvent>(
      (event, emit) async {
        await event.when(
          loadCameras: () async => await _loadCameras(
            emit,
          ),
        );
      },
    );
  }

  FutureOr<void> _loadCameras(
    Emitter<AddPhotoState> emit,
  ) async {
    List<CameraDescription> cameras = await availableCameras();
    CameraController cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await cameraController.initialize();

      emit(CamerasReady(controller: cameraController));
    } catch (e) {
      log(e.toString());
    }
  }
}
