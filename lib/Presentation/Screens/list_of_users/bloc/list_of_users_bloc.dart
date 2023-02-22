import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_persons_from_collection_use_case.dart';

import 'list_of_users_event.dart';
import 'list_of_users_state.dart';

class ListOfUsersBloc extends Bloc<ListOfUsersEvent, ListOfUsersState> {
  final GetCurrentPersonUseCase getCurrentPerson;
  final GetPersonsFromCollectionUseCase getPersonsFromCollection;
  final String docId;
  final String label;

  ListOfUsersBloc(
    this.getCurrentPerson,
    this.getPersonsFromCollection,
    this.docId,
    this.label,
  ) : super(Initial(docId, label)) {
    add(LoadUsers(docId, label));
    on<ListOfUsersEvent>(
      (event, emit) async {
        await event.when(
          loadUsers: (docId, labal) async => await _loadUsers(
            docId,
            labal,
            emit,
          ),
        );
      },
    );
  }

  FutureOr<void> _loadUsers(
    String docId,
    String label,
    Emitter<ListOfUsersState> emit,
  ) async {
    List<PersonEntity> users = [];

    if (label == 'Likes') {
      final usersOrFailure = await getPersonsFromCollection(
        GetPersonsFromCollectionParams(
          "Posts",
          label,
          docId,
        ),
      );
      usersOrFailure.fold((l) => null, (result) => users = result);
    } else {
      final usersOrFailure = await getPersonsFromCollection(
        GetPersonsFromCollectionParams(
          "Users",
          label,
          docId,
        ),
      );
      usersOrFailure.fold((l) => null, (result) => users = result);
    }

    emit(Loaded(docId, label, users));
  }
}
