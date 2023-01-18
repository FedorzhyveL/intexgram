import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/add_photo_screen/bloc/add_photo_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/get_photo_widget.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/add_photo_event.dart';
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
      create: (context) => bloc..add(const LoadCameras()),
      child: BlocBuilder<AddPhotoBloc, AddPhotoState>(
        builder: (context, state) {
          // bloc.add(const LoadCameras());
          return state.when(
            initial: () {
              return Scaffold(
                body: Center(
                  child: IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () async {
                      await showModalBottomSheet<File?>(
                        context: context,
                        builder: (context) {
                          return const GetPhotoWidget();
                        },
                      ).then(
                        (value) {
                          value == null
                              ? serverLocator<FlutterRouter>().pop()
                              : serverLocator<FlutterRouter>()
                                  .push(AddPostPageRoute(photo: value));
                        },
                      );
                    },
                  ),
                ),
              );
            },
            camerasReady: (controller) {
              cameraController = controller;
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
                        cameraController.setFlashMode(FlashMode.off);
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
