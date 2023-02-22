import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

class GetPhotoWidget extends StatelessWidget {
  const GetPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text(
            'Gallery',
            style: TextStyles.text,
          ),
          onTap: () async {
            final photo =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (photo != null) {
              final file = File(photo.path);
              serverLocator<FlutterRouter>().pop(file);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_camera),
          title: const Text(
            'Camera',
            style: TextStyles.text,
          ),
          onTap: () async {
            final photo =
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (photo != null) {
              final file = File(photo.path);
              serverLocator<FlutterRouter>().pop(file);
            }
          },
        ),
      ],
    );
  }
}
