import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/set_current_person_use_case.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/locator_service.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SetCurrentPersonUseCase setCurrentPerson;
  final GetCurrentPersonUseCase getCurrentPerson;
  SignUpBloc(this.setCurrentPerson, this.getCurrentPerson)
      : super(const Initial()) {
    on<SignUpEvent>(
      (event, emit) async {
        await event.when(
          signUp: (
            emailController,
            passwordController,
            userNameController,
            nickNameController,
          ) async =>
              await _signUpPressed(
            emailController,
            passwordController,
            userNameController,
            nickNameController,
            emit,
          ),
        );
      },
    );
  }

  FutureOr<void> _signUpPressed(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController userNameController,
    TextEditingController nickNameController,
    Emitter<SignUpState> emit,
  ) async {
    String email = format(emailController.text).toLowerCase();
    String password = format(passwordController.text);
    String nickName = format(nickNameController.text);
    String userName = format(userNameController.text);

    try {
      await FirebaseFirestore.instance.collection("Users").get().then(
        ((value) {
          for (var doc in value.docs) {
            if (doc.get("Nick Name") == nickName) {
              nickNameController.clear();
              nickName = '';
            }
            if (doc.get("Email") == email) {
              emailController.clear();
              email = '';
            }
          }
        }),
      );

      if (!EmailValidator.validate(email)) {
        emailController.clear();
        email = '';
      }

      if (nickName != '' && EmailValidator.validate(email)) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        await setCurrentPerson(
          SetCurrentPersonParams(
              profileImagePath: "default/default_profile_image.png",
              email: email,
              password: password,
              nickName: nickName,
              userName: userName,
              description: null),
        );
        var failureOrPerson = await getCurrentPerson(
            GetCurrentPersonParams(email: email, fromCache: false));
        failureOrPerson.fold(
          (l) => null,
          (user) async {
            emit(const Succes());
            await serverLocator<FlutterRouter>()
                .replace<bool>(ProfileInformationRoute(user: user));
            serverLocator<FlutterRouter>().replaceAll(
              [const MainScreenRoute()],
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use' || e.code == 'invalid-email') {
        emailController.clear();
      } else {
        if (e.code == 'weak-password') {
          passwordController.clear();
        } else {
          emailController.clear();
          passwordController.clear();
        }
      }
    }
  }

  String format(String text) {
    while (text.endsWith(' ')) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }
}
