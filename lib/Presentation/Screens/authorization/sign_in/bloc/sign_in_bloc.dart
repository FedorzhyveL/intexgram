import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../locator_service.dart';
import '../../../../Routes/router.gr.dart';
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
        email: _format(email),
        password: _format(password),
      );
      serverLocator<FlutterRouter>().replace(const MainScreenRoute());
    } on FirebaseAuthException catch (e) {
      emit(const Initial());
    }
  }

  String? validateEmail(String? email) {
    if (email == null) return "Email shouldn't be empty";

    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _format(email),
        password: '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Email incorrect";
      } else if (e.code == 'invalid-email') {
        return "Email incorrect";
      } else {
        if (e.code == 'user-disabled') {
          return "Email incorrect";
        } else {
          return 'Email or password incorrect';
        }
      }
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null) return "Password shouldn't be empty";

    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '',
        password: _format(password),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return "Password incorrect";
      } else {
        return 'Email or password incorrect';
      }
    }
    return null;
  }

  String _format(String text) {
    while (text.endsWith(' ')) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }
}
