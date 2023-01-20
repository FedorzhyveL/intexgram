import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/core/error/failure.dart';

import 'main_screen_event.dart';
import 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final GetCurrentPersonUseCase getCurrentPerson;
  MainScreenBloc(this.getCurrentPerson) : super(const Initial()) {
    on<MainScreenEvent>(
      (event, emit) async {
        await event.when(
          loadUser: () async => await _loadUsers(emit),
        );
      },
    );
  }

  FutureOr<void> _loadUsers(
    Emitter<MainScreenState> emit,
  ) async {
    final failureOrPerson = await getCurrentPerson(
      GetCurrentPersonParams(
          email: FirebaseAuth.instance.currentUser!.email.toString(),
          fromCache: false),
    );
    return failureOrPerson.fold(
      (failure) => Failure,
      (user) async {
        List<CameraDescription> cameras = await availableCameras();
        CameraController cameraController = CameraController(
          cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
        );
        emit(UserLoaded(user, cameraController));
      },
    );
  }
}
