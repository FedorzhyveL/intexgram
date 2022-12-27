import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../locator_service.dart';
import '../../../../Routes/router.gr.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signIn(
      String email, String password, GlobalKey<FormState> formKey) async {
    email = format(email);
    password = format(password);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      formKey.currentState!.reset();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(SignInWrongEmail());
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        emit(SignInWrongPassword());
      } else {
        print(e.code.toString());
      }
    }

    if (FirebaseAuth.instance.currentUser != null) {
      serverLocator<FlutterRouter>().replace(const MainScreenRoute());
    }
  }

  String format(String text) {
    while (text.endsWith(' ')) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }
}
