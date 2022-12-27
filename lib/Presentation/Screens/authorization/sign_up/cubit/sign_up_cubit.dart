import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/usecases/set_current_person_use_case.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/locator_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SetCurrentPersonUseCase setCurrentPersonUseCase;
  SignUpCubit(this.setCurrentPersonUseCase) : super(SignUpInitial());

  Future<void> setUser(
      String email, String password, String userName, String nickName) async {
    email = format(email).toLowerCase();
    password = format(password);
    nickName = format(nickName);
    userName = format(userName);
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.code.toString());
      }
    }
    if (FirebaseAuth.instance.currentUser != null) {
      setCurrentPersonUseCase(
        CurrentPersonParams(
            email: email,
            password: password,
            nickName: nickName,
            userName: userName),
      );
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      serverLocator<FlutterRouter>().replaceAll([const MainScreenRoute()]);
    }
  }
}

String format(String text) {
  while (text.endsWith(' ')) {
    text = text.substring(0, text.length - 1);
  }
  return text;
}
