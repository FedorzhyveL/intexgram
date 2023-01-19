import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_all_persons_use_case.dart';

import 'search_page_event.dart';
import 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  final GetAllPersonsUseCase getAllPersonsUseCase;
  SearchPageBloc(this.getAllPersonsUseCase) : super(const Initial()) {
    on<SearchPageEvent>(
      (event, emit) async {
        await event.when(
          getAllUsers: (() async => await _getAllUsers(
                emit,
              )),
          updateList: ((users) async => await _updateList(
                users,
                emit,
              )),
        );
      },
    );
  }

  FutureOr<void> _getAllUsers(
    Emitter<SearchPageState> emit,
  ) async {
    final allUsers = await getAllPersonsUseCase(true);
    allUsers.fold((l) => null, (users) => emit(Loaded(users)));
  }

  FutureOr<void> _updateList(
    List<PersonEntity> users,
    Emitter<SearchPageState> emit,
  ) {
    emit(const Initial());
    emit(Loaded(users));
  }
}
