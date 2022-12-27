import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/usecases/get_current_person_use_case.dart';
import 'package:intexgram/core/error/failure.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentPersonUseCase getCurrentPersons;
  UserCubit({required this.getCurrentPersons}) : super(UserInitial());

  void getUser() {
    if (state is UserInitial) loadUser();
  }

  void loadUser() async {
    final failureOrPerson = await getCurrentPersons(CurrentPersonParams(
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        fromCache: false));
    failureOrPerson.fold((failure) => Failure, (user) => emit(UserLoaded()));
  }
}
