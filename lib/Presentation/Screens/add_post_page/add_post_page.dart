import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/add_post_page/bloc/add_post_bloc.dart';
import 'package:intexgram/Presentation/Screens/add_post_page/bloc/add_post_event.dart';
import 'package:intexgram/Presentation/Screens/widgets/form_text_field.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/add_post_state.dart';

class AddPostPage extends StatefulWidget {
  final File photo;
  const AddPostPage({
    super.key,
    required this.photo,
  });
  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  var descriptionController = TextEditingController();
  late final AddPostBloc bloc;
  @override
  void initState() {
    bloc = AddPostBloc(
      serverLocator(),
      serverLocator(),
      widget.photo,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) {
          if (state is Loaded) {
            serverLocator<FlutterRouter>()
                .replaceAll([const MainScreenRoute()]);
          }
        },
        builder: (context, state) {
          return state.when(
            initial: (photo) => content(state),
            loading: (photo) => content(state),
            loaded: () => Container(),
          );
        },
      ),
    );
  }

  Widget content(AddPostState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.appBarIconColor,
            size: 35,
          ),
          onPressed: () {
            serverLocator<FlutterRouter>().pop();
          },
        ),
        title: const Text(
          "New post",
          style: TextStyles.appBarText,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.task_alt_rounded,
              size: 35,
              color: Palette.appBarIconColor,
            ),
            onPressed: () {
              if (state is Initial) {
                bloc.add(
                  AddPostToDb(
                    photo: state.photo,
                    description: descriptionController.text,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/photos/original.jpg'),
                  radius: 30,
                ),
                Expanded(
                  child: FormTextField(
                    label: "Description",
                    controller: descriptionController,
                    maxLines: 100,
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: FittedBox(
                    clipBehavior: Clip.hardEdge,
                    fit: BoxFit.cover,
                    child: Image.file(widget.photo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
