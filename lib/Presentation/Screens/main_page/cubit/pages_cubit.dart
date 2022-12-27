import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/usecases/get_current_person_use_case.dart';
import 'package:intexgram/core/error/failure.dart';

part 'pages_state.dart';

class PagesCubit extends Cubit<PagesState> {
  final GetCurrentPersonUseCase getCurrentPersons;
  PagesCubit(this.getCurrentPersons) : super(PagesInitial());

  void getUser() {
    if (state == PagesInitial()) {
      loadUser();
    }
  }

  void loadUser() async {
    final failureOrPerson = await getCurrentPersons(CurrentPersonParams(
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        fromCache: true));
    failureOrPerson.fold((failure) => Failure, (user) => emit(PageReady(user)));
  }
}
