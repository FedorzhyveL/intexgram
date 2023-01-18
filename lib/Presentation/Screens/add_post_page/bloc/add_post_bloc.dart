import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/change_photo_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/create_post_use_case.dart';
import 'package:path/path.dart';

import '../../../../locator_service.dart';
import '../../../Routes/router.gr.dart';
import 'add_post_event.dart';
import 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final CreatePostUseCase createPost;
  final ChangePhotoUseCase addPhotoToDb;
  final File photo;
  AddPostBloc(
    this.createPost,
    this.addPhotoToDb,
    this.photo,
  ) : super(Initial(photo)) {
    on<AddPostEvent>(
      (event, emit) async {
        await event.when(
          addPostToDb: (photo, description) async => await _addPostToDb(
            photo,
            description,
            emit,
          ),
        );
      },
    );
  }

  FutureOr<void> _addPostToDb(
    File photo,
    String description,
    Emitter<AddPostState> emit,
  ) async {
    emit(Loading(photo));
    try {
      await addPhotoToDb(ChangePhotoParams(photo: photo));
      await createPost(
        CreatePostParams(
          imagePath: 'images/${basename(photo.path)}',
          userEmail: FirebaseAuth.instance.currentUser!.email.toString(),
          description: description,
          creationTime: DateTime.now(),
        ),
      );
      serverLocator<FlutterRouter>().replaceAll([const MainScreenRoute()]);
    } catch (e) {
      log(e.toString());
    }
  }
}
