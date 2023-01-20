import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/add_photo_screen/bloc/add_photo_bloc.dart';
import 'package:intexgram/locator_service.dart';

import '../main_screen/bloc/main_screen_bloc.dart';
import '../main_screen/bloc/main_screen_state.dart';
import 'bloc/add_photo_state.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  late final AddPhotoBloc bloc;
  late CameraController cameraController;
  @override
  void initState() {
    bloc = AddPhotoBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<AddPhotoBloc, AddPhotoState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              cameraController =
                  (context.read<MainScreenBloc>().state as UserLoaded)
                      .cameraController;
              if (!cameraController.value.isInitialized) {
                cameraController.initialize();
              }
              cameraController.resumePreview();
              return SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  body: Column(
                    children: [
                      Expanded(child: CameraPreview(cameraController)),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      try {
                        final image = await cameraController.takePicture();

                        if (!mounted) return;

                        serverLocator<FlutterRouter>()
                            .push(AddPostPageRoute(photo: File(image.path)));
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                  ),
                ),
              );
            },
            camerasReady: (controller) {
              cameraController =
                  (context.read<MainScreenBloc>().state as UserLoaded)
                      .cameraController;
              if (!cameraController.value.isInitialized) {
                cameraController.initialize();
              }
              return SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  body: Column(
                    children: [
                      Expanded(child: CameraPreview(cameraController)),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      try {
                        final image = await cameraController.takePicture();

                        if (!mounted) return;

                        serverLocator<FlutterRouter>()
                            .push(AddPostPageRoute(photo: File(image.path)));
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
