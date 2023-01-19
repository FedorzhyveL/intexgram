import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/profile_information/bloc/profile_information_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/form_text_field.dart';
import 'package:intexgram/Presentation/Screens/widgets/get_photo_widget.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/profile_information_event.dart';
import 'bloc/profile_information_state.dart';

class ProfileInformation extends StatefulWidget {
  final PersonEntity user;

  const ProfileInformation({
    super.key,
    required this.user,
  });
  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  var descriptionController = TextEditingController();
  var nickNameController = TextEditingController();
  var userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? newPhoto;

  late final ProfileInformationBloc bloc;
  @override
  void initState() {
    bloc = ProfileInformationBloc(
      serverLocator(),
      serverLocator(),
    );
    nickNameController.text = widget.user.nickName;
    userNameController.text = widget.user.userName;
    descriptionController.text =
        widget.user.description == null ? '' : widget.user.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<ProfileInformationBloc, ProfileInformationState>(
        builder: (context, state) {
          return state.when(
            initial: (() => content(state, context)),
            photoUpdated: ((photo) => content(state, context)),
            exit: ((isChanged) {
              serverLocator<FlutterRouter>().pop(isChanged);
              return content(state, context);
            }),
          );
        },
      ),
    );
  }

  Widget content(ProfileInformationState state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Palette.appBarIconColor,
          ),
          onPressed: () {
            serverLocator<FlutterRouter>().pop();
          },
        ),
        title: Text(
          "Input profile information",
          style: TextStyles.appBarText.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.task_alt_rounded,
              size: 35,
              color: Palette.appBarIconColor,
            ),
            onPressed: () {
              bloc.add(
                SubmitButtonPressed(
                  nickNameController.text,
                  userNameController.text,
                  descriptionController.text,
                  widget.user,
                  state is PhotoUpdated ? state.photo : null,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: state is PhotoUpdated
                      ? Image.file(state.photo).image
                      : CachedNetworkImageProvider(
                          widget.user.profilePicturePath),
                  radius: 30,
                ),
                TextButton(
                  child: const Text(
                    'Add or edit profile photo',
                    style: TextStyles.text,
                  ),
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
                            : bloc.add(UpdatePhoto(value));
                      },
                    );
                  },
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormTextField(
                        label: "Nick name",
                        controller: nickNameController,
                        validation: (nickName) {
                          String? message;
                          bloc
                              .validateNickName(nickName)
                              .then((value) => message = value);
                          return message;
                        },
                      ),
                      FormTextField(
                        label: "User name",
                        controller: userNameController,
                        validation: (userName) =>
                            bloc.validateUserName(userName),
                      ),
                      FormTextField(
                        label: "Description",
                        controller: descriptionController,
                        maxLines: 5,
                        validation: (description) => null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
