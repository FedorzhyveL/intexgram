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
            email,
            password,
            userName,
            nickName,
          ) async =>
              await _signUpPressed(
            email,
            password,
            userName,
            nickName,
          ),
        );
      },
    );
  }

  FutureOr<void> _signUpPressed(
    String email,
    String password,
    String userName,
    String nickName,
  ) async {
    String newEmail = _format(email).toLowerCase();
    String newPassword = _format(password);
    String newUserName = _format(userName);
    String newNickName = _format(nickName);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: newEmail,
        password: newPassword,
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: newEmail,
        password: newPassword,
      );

      await setCurrentPerson(
        SetCurrentPersonParams(
          profileImagePath: "default/default_profile_image.png",
          email: newEmail,
          password: newPassword,
          nickName: newNickName,
          userName: newUserName,
          description: null,
        ),
      );
      var failureOrPerson = await getCurrentPerson(
          GetCurrentPersonParams(email: newEmail, fromCache: false));
      failureOrPerson.fold(
        (l) => null,
        (user) async {
          await serverLocator<FlutterRouter>()
              .replace<bool>(ProfileInformationRoute(user: user));
          serverLocator<FlutterRouter>().replaceAll(
            [const MainScreenRoute()],
          );
        },
      );
    } catch (e) {
      return;
    }
  }

  Future<String?> validateEmail(String? email) async {
    if (email == null) return "Email shouldn't be empty";

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _format(email),
        password: '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "This email not allowed";
      } else {
        if (e.code == 'invalid-email') {
          return "This email not allowed";
        } else {
          if (e.code == 'operation-not-allowed') {
            return "This email not allowed";
          }
        }
      }
    }

    if (EmailValidator.validate(email)) return "This email not allowed";
    return null;
  }

  Future<String?> validatePassword(String? password) async {
    if (password == null) return "Password shouldn't be empty";

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '',
        password: _format(password),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Weak password";
      } else {
        if (e.code == 'operation-not-allowed') {
          return "Weak password";
        }
      }
    }
    return null;
  }

  Future<String?> validateNickName(String? nickName) async {
    if (nickName == null) return "Nick name shouldn exist";

    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .where(
            "Nick Name",
            isEqualTo: nickName,
          )
          .get()
          .then(
        ((value) {
          for (var doc in value.docs) {
            if (doc.get("Nick Name") == nickName) {
              return "This nick name is already in use";
            }
          }
        }),
      );
    } catch (e) {
      return "Something went wrong";
    }
    return null;
  }

  String? validateUserName(String? userName) {
    if (userName == null) return "User name should exist";

    return null;
  }

  String _format(String text) {
    while (text.endsWith(' ')) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }
}
