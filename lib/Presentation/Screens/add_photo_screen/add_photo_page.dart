import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
    cameraController =
        (context.read<MainScreenBloc>().state as UserLoaded).cameraController;
    bloc = AddPhotoBloc(cameraController);
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
            initial: (controller) {
              return const Center(
                child: Text("Camera not allowed. Change it in settings"),
              );
            },
            camerasReady: (controller) {
              return SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: [
                      Positioned.fill(child: CameraPreview(cameraController)),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () async {
                              try {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  serverLocator<FlutterRouter>().push(
                                      AddPostPageRoute(
                                          photo: File(image.path)));
                                }
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            icon: const Icon(
                              Icons.filter,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () async {
                              try {
                                final image =
                                    await cameraController.takePicture();

                                if (!mounted) return;

                                serverLocator<FlutterRouter>().push(
                                  AddPostPageRoute(photo: File(image.path)),
                                );
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            icon: const Icon(
                              Icons.photo_camera_outlined,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
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
