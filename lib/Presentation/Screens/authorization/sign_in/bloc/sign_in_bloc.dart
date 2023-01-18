import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const Initial()) {
    on<SignInEvent>(
      (event, emit) async {
        await event.when(
          signIn: (email, password) async => await _signInToApp(
            email,
            password,
            emit,
          ),
        );
      },
    );
  }

  FutureOr<void> _signInToApp(
    String email,
    String password,
    Emitter<SignInState> emit,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: format(email),
        password: format(password),
      );
      emit(const Succes());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const WrongEmail());
      } else if (e.code == 'wrong-password') {
        emit(const WrongPassword());
      } else {}
    }
  }

  String format(String text) {
    while (text.endsWith(' ')) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }
}
