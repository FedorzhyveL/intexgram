import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/set_current_person_use_case.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SetCurrentPersonUseCase setCurrentPerson;
  final GetCurrentPersonUseCase getCurrentPerson;
  SignUpBloc(
    this.setCurrentPerson,
    this.getCurrentPerson,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController nickNameController,
    TextEditingController userNameController,
  ) : super(
          Initial(
            emailController,
            passwordController,
            nickNameController,
            userNameController,
          ),
        ) {
    on<SignUpEvent>(
      (event, emit) async {
        await event.when(
          signUp: (state) async => await _signUpPressed(state, emit),
        );
      },
    );
  }

  FutureOr<void> _signUpPressed(
    SignUpState state,
    Emitter<SignUpState> emit,
  ) async {
    if (state is Initial) {
      String email = format(state.emailController.text).toLowerCase();
      String password = format(state.passwordController.text);
      String nickName = format(state.nickNameController.text);
      String userName = format(state.userNameController.text);

      await FirebaseFirestore.instance.collection("Users").get().then(
        ((value) {
          for (var doc in value.docs) {
            if (doc.get("Nick Name") == nickName) {
              state.nickNameController.clear();
              nickName = '';
            }
          }
        }),
      );

      if (!EmailValidator.validate(email)) {
        state.emailController.clear();
        email = '';
      }

      if (nickName != '') {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        } catch (e) {
          state.emailController.clear();
          state.passwordController.clear();
          return;
        }

        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } catch (e) {
          state.emailController.clear();
          state.passwordController.clear();
          return;
        }

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

        failureOrPerson.fold((l) => null, (user) => emit(Succes(user)));
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
