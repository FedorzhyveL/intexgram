import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) : super(Initial(emailController, passwordController)) {
    on<SignInEvent>(
      (event, emit) async {
        await event.when(
          signIn: (state) async => await _signInToApp(
            state,
            emit,
          ),
        );
      },
    );
  }

  FutureOr<void> _signInToApp(
    SignInState state,
    Emitter<SignInState> emit,
  ) async {
    if (state is Initial) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: format(state.emailController.text),
          password: format(state.passwordController.text),
        );
        emit(const Succes());
      } on FirebaseAuthException catch (_) {
        state.emailController.clear();
        state.passwordController.clear();
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
